import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/widgets/bottom_nav_bar.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      // Already on UsersScreen, do nothing
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/settings');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    String getUsername() {
      if (user == null) return 'Guest';
      if (user.displayName != null) return user.displayName!;
      if (user.email != null) return user.email!.split('@').first;
      return 'User';
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/anonym icon.jpg'),
            ),
            const SizedBox(height: 20),
            Text(
              getUsername(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (user?.email != null)
              Text(
                user!.email!,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
