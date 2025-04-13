import 'package:SmartHomeAssistance/welcome_screen.dart';
import 'package:SmartHomeAssistance/homescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:SmartHomeAssistance/auth_service.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:SmartHomeAssistance/services/database_service.dart';
import 'package:SmartHomeAssistance/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();
  final DatabaseReference _database = DatabaseService.instance.reference;

  Home({super.key});

  Future<bool> _isHouseConfigComplete(String userId) async {
    final snapshot = await _database.child('users/$userId/houseId').get();
    if (snapshot.exists && snapshot.value != null) {
      String houseId = snapshot.value as String;

      // Send notification with house ID
      _sendNotification(userId, "Your house ID is $houseId");

      return true;
    }
    return false;
  }

  void _sendNotification(String userId, String message) {
    // Implement Firebase Cloud Messaging to send notifications
    print("Notification sent to $userId: $message");
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _authService.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            return Login();
          } else {
            return FutureBuilder<bool>(
              future: _isHouseConfigComplete(user.uid),
              builder: (context, configSnapshot) {
                if (configSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (configSnapshot.hasData &&
                    configSnapshot.data == true) {
                  return HomeScreen(database: _database, currentUser: user);
                } else {
                  return WelcomeScreen();
                }
              },
            );
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
