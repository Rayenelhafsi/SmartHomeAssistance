import 'package:flutter/material.dart';
import 'package:main/login.dart';

void main() {
  runApp(SmartHomeApp());
}

class SmartHomeApp extends StatelessWidget {
  const SmartHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: loginscreen(),
    );
  }
}
