import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synkrama_test/screens/dashboard_screen.dart';
import 'package:synkrama_test/screens/sign_in_screen.dart';
import 'package:synkrama_test/screens/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Synkrama_Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: isLoggedIn ? '/dashboard' : '/signin',
      routes: {
        '/signin': (context) => SignInScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/dashboard': (context) => DashboardScreen(),
      },
    );
  }
}
