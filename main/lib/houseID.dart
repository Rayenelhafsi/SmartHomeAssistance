import 'package:SmartHomeAssistance/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

// ignore: must_be_immutable
class houseID extends StatelessWidget {
  var IDcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
          actions: [
            Icon(Icons.more_horiz_outlined, color: Colors.white),
            SizedBox(width: 20),
          ],
          backgroundColor: const Color.fromARGB(255, 20, 9, 48),
        ),
        backgroundColor: Color(0xFF0D0F1E),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 200),
                Text(
                  'INSERT YOUR CODE',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(height: 60),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: IDcontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: const Color.fromARGB(38, 170, 144, 144),
                    ),
                    labelText: 'HOUSE ID',
                    prefixIcon: Icon(Icons.code),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 40),
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => HomeScreen(
                              database: FirebaseDatabase.instance.ref(),
                              currentUser: FirebaseAuth.instance.currentUser,
                            ),
                      ),
                    );
                  },
                  child: Text('SUBMIT'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
