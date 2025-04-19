import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/widgets/bottom_nav_bar.dart';
import '../services/database_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 1;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;
  String? _feedbackMessage;

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      // Already on ProfileScreen, do nothing
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/settings');
    }
  }

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _usernameController.text = user.displayName ?? '';
      _emailController.text = user.email ?? '';
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() {
      _isLoading = true;
      _feedbackMessage = null;
    });

    try {
      final profileData = {
        'displayName': _usernameController.text.trim(),
        'email': _emailController.text.trim(),
      };
      await DatabaseService.instance.updateUserProfile(user.uid, profileData);

      setState(() {
        _feedbackMessage = 'Profile updated successfully.';
      });
    } catch (e) {
      setState(() {
        _feedbackMessage = 'Failed to update profile: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/anonym icon.jpg'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: _saveProfile,
                  child: const Text('Save'),
                ),
            if (_feedbackMessage != null) ...[
              const SizedBox(height: 20),
              Text(
                _feedbackMessage!,
                style: TextStyle(
                  color:
                      _feedbackMessage!.startsWith('Failed')
                          ? Colors.red
                          : Colors.green,
                ),
              ),
            ],
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
