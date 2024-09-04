import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  bool _agreeToTerms = false;
  bool _showPassword = true;

  Future<void> _signUp() async {
    debugPrint(_password);
    debugPrint(_confirmPassword);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("name",_name);
      await prefs.setString("email",_email);
      await prefs.setString("password",_password);
      await prefs.setBool('isLoggedIn', true);
      Navigator.pushReplacementNamed(context, '/dashboard');
      _formKey.currentState!.save();
    }
  }

  showPassword(){
    setState(() {
      _showPassword=!_showPassword;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Sign Up", style: TextStyle(fontSize: 30),),
                  const SizedBox(height: 50),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name', hintText: "Please Enter Your Name", border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onSaved: (value) => _name = value!,
                  ),
                  const SizedBox(height: 10,),

                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email or not contain @ ';
                      }
                      return null;
                    },
                    onSaved: (value) => _email = value!,
                  ),
                  const SizedBox(height: 10,),

                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    onChanged: (value) => _password = value.toString(),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    decoration: InputDecoration(
                      suffixIcon:IconButton(
                          onPressed: showPassword, icon:  _showPassword?const Icon(Icons.remove_red_eye_outlined):const Icon(Icons.visibility_off)),
                        labelText: 'Confirm Password', border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),

                    )),
                    obscureText: _showPassword,
                    validator: (value) {
                      if (value!.isEmpty || value != _password) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    onChanged: (value) => _confirmPassword = value.toString(),
                  ),
                  CheckboxListTile(
                    title: const Text('Agree to Terms and Conditions'),
                    value: _agreeToTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreeToTerms = value!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _agreeToTerms ? _signUp : null,
                      style: ElevatedButton.styleFrom(backgroundColor: _agreeToTerms?Colors.blueAccent:Colors.grey),
                      child:  Text('Sign Up',style: TextStyle(color: _agreeToTerms?Colors.white:Colors.black),),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Already have an account? Sign In'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
