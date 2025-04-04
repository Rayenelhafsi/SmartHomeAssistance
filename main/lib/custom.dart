import 'package:SmartHomeAssistance/houseconfig.dart';
import 'package:flutter/material.dart';

class Custom extends StatefulWidget {

  @override
  State<Custom> createState() => _CustomState();
}

class _CustomState extends State<Custom> {
  @override
  Widget build(BuildContext context) {
    var housenamecontroller=TextEditingController();
    var addresscontroller=TextEditingController();
    var ownercontroller=TextEditingController();
    var phonecontroller=TextEditingController();
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
                  FloatingActionButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => houseconfig()),
              );
                      },
                      child: Text(
              'CREATE',
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