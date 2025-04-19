import 'package:flutter/material.dart';
import 'package:SmartHomeAssistance/widgets/bottom_nav_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/all_users');
    } else if (index == 2) {
      // Already on SettingsScreen, do nothing
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFF0D0F1E),
      ),
      backgroundColor: const Color(0xFF0D0F1E),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          // Profile Settings
          ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title: const Text(
              'Profile Settings',
              style: TextStyle(color: Colors.white),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            onTap: () {
              // Navigate to Profile Settings
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileSettingsScreen(),
                ),
              );
            },
          ),
          const Divider(color: Colors.grey),

          // Home Settings
          ListTile(
            leading: const Icon(Icons.home, color: Colors.white),
            title: const Text(
              'Home Settings',
              style: TextStyle(color: Colors.white),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            onTap: () {
              // Navigate to Home Settings
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeSettingsScreen()),
              );
            },
          ),
          const Divider(color: Colors.grey),

          // Contact Us
          ListTile(
            leading: const Icon(Icons.contact_mail, color: Colors.white),
            title: const Text(
              'Contact Us',
              style: TextStyle(color: Colors.white),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            onTap: () {
              // Navigate to Contact Us
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactUsScreen()),
              );
            },
          ),
          const Divider(color: Colors.grey),

          // Exercise Mode (Under Development)
          ListTile(
            leading: const Icon(Icons.fitness_center, color: Colors.white),
            title: const Text(
              'Exercise Mode (Under Development)',
              style: TextStyle(color: Colors.white),
            ),
            trailing: const Icon(Icons.construction, color: Colors.white),
            onTap: () {
              // Show a message for under development
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Exercise Mode is under development.'),
                ),
              );
            },
          ),
          const Divider(color: Colors.grey),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

// Profile Settings Screen
class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Settings'),
        backgroundColor: const Color(0xFF0D0F1E),
      ),
      backgroundColor: const Color(0xFF0D0F1E),
      body: Center(
        child: const Text(
          'Profile Settings Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

// Home Settings Screen
class HomeSettingsScreen extends StatelessWidget {
  const HomeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Settings'),
        backgroundColor: const Color(0xFF0D0F1E),
      ),
      backgroundColor: const Color(0xFF0D0F1E),
      body: Center(
        child: const Text(
          'Home Settings Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

// Contact Us Screen
class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
        backgroundColor: const Color(0xFF0D0F1E),
      ),
      backgroundColor: const Color(0xFF0D0F1E),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Contact Us',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Email: Support@SmartHomeAssistance.tn',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Phone: +216 24 879 087',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Address: 104 Rue des Martyrs \nKélibia, Tunisia',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
