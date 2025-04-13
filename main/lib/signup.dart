import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:SmartHomeAssistance/auth_service.dart';
import 'package:SmartHomeAssistance/welcome_screen.dart';

// ignore: must_be_immutable
class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final AuthService _authService = AuthService(); // Initialize AuthService
  var emailController = TextEditingController();
  var namecontroller = TextEditingController();
  var lastnamecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var passwordController = TextEditingController();
  bool showpass = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          backgroundColor: Color(0xFF0D0F1E),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Sign up',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w900,
                      fontSize: 60,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Let\'s start your free trial',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: lastnamecontroller,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: const Color.fromARGB(38, 170, 144, 144),
                      ),
                      labelText: 'Your Last Name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: namecontroller,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: const Color.fromARGB(38, 170, 144, 144),
                      ),
                      labelText: 'Your Name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: const Color.fromARGB(38, 170, 144, 144),
                      ),
                      labelText: 'Email Address',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: phonecontroller,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: const Color.fromARGB(38, 170, 144, 144),
                      ),
                      labelText: 'Your Phone number',
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: showpass,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        onPressed: () {
                          setState(() {
                            showpass = !showpass;
                          });
                        },
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    color: Colors.purple,
                    child: MaterialButton(
                      onPressed: () async {
                        User? user = await _authService
                            .signUpWithEmailAndPassword(
                              emailController.text,
                              passwordController.text,
                            );
                        if (user != null) {
                          print('User registered: ${user.email}');
                          // Navigate to the login page
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomeScreen(),
                            ), // Ensure Login is imported
                          );
                        } else {
                          print('Sign-up failed');
                        }
                      },
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Color(0xFF0D0F1E),
      ),
    );
  }
}
