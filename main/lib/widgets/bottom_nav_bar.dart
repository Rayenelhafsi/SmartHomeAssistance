import 'package:flutter/material.dart';
import 'package:SmartHomeAssistance/screens/homescreen.dart';
import 'package:SmartHomeAssistance/screens/all_users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:SmartHomeAssistance/screens/settings_screen.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xFF1E1F2F),
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.white70,
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "HOME"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "USERS"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "SETTINGS"),
      ],
    );
  }
}
