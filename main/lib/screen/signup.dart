import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable
class signup extends StatefulWidget {
  // Change to StatefulWidget
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<signup> {
  // Create the State class

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String lastname,
    required String phone,
  }) async {
    try {
      // Create user with email and password
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Get the user ID
      String userId = userCredential.user!.uid;

      // Store additional user details in Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'name': name,
        'lastname': name,
        'email': email,
        'phone': phone,
        'createdAt': DateTime.now(),
      });

      print("User signed up and details saved: ${userCredential.user!.email}");
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.message}");
    }
  }

  var emailController = TextEditingController();
  var namecontroller = TextEditingController();
  var lastnamecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmController = TextEditingController();
  bool isCheckedchild = false;
  bool isCheckedparent = false;
  bool showpass = true;
  bool showpassconf = true;
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
                  SizedBox(height: 20),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: lastnamecontroller,
                    keyboardType: TextInputType.name,
                    onFieldSubmitted: (String value) {
                      print(value);
                    },
                    onChanged: (String value) {
                      print(value);
                    },
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
                    onFieldSubmitted: (String value) {
                      print(value);
                    },
                    onChanged: (String value) {
                      print(value);
                    },
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
                    onFieldSubmitted: (String value) {
                      print(value);
                    },
                    onChanged: (String value) {
                      print(value);
                    },
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
                    onFieldSubmitted: (String value) {
                      print(value);
                    },
                    onChanged: (String value) {
                      print(value);
                    },
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
                    obscureText: showpassconf,
                    onFieldSubmitted: (String value) {
                      print(value);
                    },
                    onChanged: (String value) {
                      print(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Password confirmation',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          showpass
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                        ),
                        onPressed: () {
                          setState(() {
                            showpass = !showpass;
                          });
                        },
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: showpass,
                    onFieldSubmitted: (String value) {
                      print(value);
                    },
                    onChanged: (String value) {
                      print(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          showpass
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                        ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: isCheckedparent,
                        onChanged: (bool? value) {
                          setState(() {
                            isCheckedparent = value!;
                          });
                        },
                      ),
                      Text(
                        isCheckedparent ? "Parent" : "Parent",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 60),
                      Checkbox(
                        value: isCheckedchild,
                        onChanged: (bool? value) {
                          setState(() {
                            isCheckedchild = value!;
                          });
                        },
                      ),
                      Text(
                        isCheckedchild ? "Child" : "Child",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      Image(
                        image: AssetImage('images/logo-test.png'),
                        height: 90,
                        width: 90,
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        color: Colors.purple,
                        child: MaterialButton(
                          onPressed: () {
                            print(emailController.text);
                            print(passwordController.text);
                            print(namecontroller.text);
                            print(phonecontroller.text);
                            print(lastnamecontroller.text);
                            signUp(name: namecontroller.text,lastname:lastnamecontroller.text,phone: phonecontroller.text,email: emailController.text,password: passwordController.text);
                          },
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
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
