import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacementNamed(context, '/signin');
  }

  String name = "";
  String email = "";

  @override
  void initState() {
    getProfileData();
    super.initState();
  }

  getProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name") ?? "";
    email = prefs.getString("email") ?? "";
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:           BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () =>  showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  scrollable: true,
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  content: const Text("If Logout User Details Also remove"),
                  actions: [
                    TextButton(
                      child: const Text("Close"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: const Text("ok"),
                      onPressed: () =>_logout(context),
                    ),
                  ],
                );
              },
            ),)
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _buildPage()),
        ],
      ),
    );
  }

  Widget _buildImageCard(String image) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Center(child: Image.asset(image)),
    );
  }

  Widget _home() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // List 1: Horizontal align images with rounded corners
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildImageCard('assets/images/Image(1).png'),
                _buildImageCard('assets/images/Image(2).png'),
                _buildImageCard('assets/images/image(3).png'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // List 2: Vertical align images with rounded corners
          _buildImageCard('assets/images/image(4).png'),
          _buildImageCard('assets/images/image(4).png'),
          const SizedBox(height: 20),
          // List 3: Grid view images with rounded corners
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            children: [
              _buildImageCard('assets/images/image(6).png'),
              _buildImageCard('assets/images/image(7).png'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _profile() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: Card(
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Profile",style: TextStyle(fontSize: 16,fontWeight:FontWeight.bold),),
                  Text("Name : $name",),
                  Text("Email : $email"),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPage() {
    switch (_selectedIndex) {
      case 0:
        return _home();
      case 1:
        return const Center(child: Text('Order Page'));
      case 2:
        return _profile();
      default:
        return const Center(child: Text('Home Page'));
    }
  }
}
