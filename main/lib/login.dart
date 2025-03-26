import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:SmartHomeAssistance/auth_service.dart';
import 'package:SmartHomeAssistance/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showpass = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 60.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  SizedBox(
                    width: 150,
                    child: Image(
                      image: AssetImage('images/smart-home-assistance.png'),
                      // height: 120,
                      // width: 120,
                    ),
                  ),
                  SizedBox(height: 40.0),
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
                  SizedBox(height: 15.0),
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
                  SizedBox(height: 25.0),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        // Disable the button to prevent multiple taps
                        // (You can add a boolean variable to manage this state)
                      });
                      User? user = await _authService.signInWithGoogle();
                      if (user != null) {
                        print('User signed in: ${user.displayName}');
                      } else {
                        print('Sign-in failed');
                      }
                    },

                    child: Text('Sign in with Google'),
                  ),
                  SizedBox(height: 25.0),
                  Container(
                    width: double.infinity,
                    color: Colors.purple,
                    child: MaterialButton(
                      onPressed: () async {
                        setState(() {
                          // Disable the button to prevent multiple taps
                          // (You can add a boolean variable to manage this state)
                        });
                        User? user = await _authService
                            .signInWithEmailAndPassword(
                              emailController.text,
                              passwordController.text,
                            );
                        if (user != null) {
                          print('User signed in: ${user.displayName}');
                        } else {
                          print('Sign-in failed');
                        }
                      },

                      child: Text(
                        'LOGIN',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextButton(
                    onPressed: () async {
                      await _authService.resetPassword(emailController.text);
                      print('Password reset email sent.');
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Signup()),
                          );
                        },
                        child: Text('Register Now'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Color(0xFF0D0F1E), // Dark theme background
      ),
    );
  }
}
