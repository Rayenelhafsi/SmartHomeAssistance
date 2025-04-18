import 'package:SmartHomeAssistance/screens/houseconfig.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:SmartHomeAssistance/services/database_service.dart';

class Custom extends StatefulWidget {
  @override
  State<Custom> createState() => _CustomState();
}

class _CustomState extends State<Custom> {
  // Initialize the database reference with the correct URL
  final DatabaseReference _database = DatabaseService.instance.reference;

  var housenamecontroller = TextEditingController();
  var addresscontroller = TextEditingController();
  var ownercontroller = TextEditingController();
  var phonecontroller = TextEditingController();

  void _saveHouseData() async {
    String userId =
        FirebaseAuth.instance.currentUser!.uid; // Get current user ID
    String houseId =
        _database.child('houses').push().key!; // Generate unique house ID

    // Save house details in the database
    await _database.child('houses/$houseId').set({
      'id': houseId,
      'houseName': housenamecontroller.text,
      'address': addresscontroller.text,
      'owner': ownercontroller.text,
      'phone': phonecontroller.text,
      'rooms': {}, // Initialize empty rooms
      'roomCounters': {
        'bedroom': 0,
        'kitchen': 0,
        'livingRoom': 0,
        'bathroom': 0,
      },
    });

    // Link the house to the user
    await _database.child('users/$userId').update({'houseId': houseId});

    // Show success message
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('House data saved successfully!')));

    // Redirect to house configuration page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => houseconfig(houseId: houseId)),
    );
  }

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
                    'Fill the blanks to customize your experience',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Let\'s start your journey',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: housenamecontroller,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: const Color.fromARGB(38, 170, 144, 144),
                      ),
                      labelText: "Your House's name",
                      prefixIcon: Icon(Icons.house),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: addresscontroller,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: const Color.fromARGB(38, 170, 144, 144),
                      ),
                      labelText: 'Your Address',
                      prefixIcon: Icon(Icons.place_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: ownercontroller,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: const Color.fromARGB(38, 170, 144, 144),
                      ),
                      labelText: 'Your Full Name',
                      prefixIcon: Icon(Icons.person),
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
                  SizedBox(height: 30),
                  FloatingActionButton(
                    onPressed: _saveHouseData,
                    child: Text('CREATE'),
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
