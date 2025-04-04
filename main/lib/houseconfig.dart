import 'package:flutter/material.dart';

class houseconfig extends StatelessWidget {
  final List<Map<String, dynamic>> rooms = [
    {'name': 'Add Kitchen', 'icon': Icons.kitchen},
    {'name': 'Add Bedroom', 'icon': Icons.bed},
    {'name': 'Add Toilet', 'icon': Icons.bathtub},
    {'name': 'Add Living Room', 'icon': Icons.weekend},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D0F1E) , 
      appBar: AppBar(
        backgroundColor: Color(0xFF0D0F1E) , 
        title: Text(
          "Smart Home",
          style: TextStyle(
            color: Colors.white,
          ),
          ),
          leading:IconButton(onPressed: (){
            Navigator.pop(context);
          }, 
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white
            ),
          ) ,
          ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          SizedBox(
            width: 120,
              child: Image(
              image: AssetImage('images/smart-home-assistance.png'),
          // height: 120,
          // width: 120,
           ),
          ),
          SizedBox(
            height: 80,
          ),
          Center( 
            child: SizedBox(
              width: 300, 
              child: GridView.builder(
                shrinkWrap: true, 
                itemCount: rooms.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${rooms[index]['name']} tapped')),
                      );
                    },
                    child: Card(
                      color: Colors.deepPurple,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(rooms[index]['icon'], size: 50, color: Colors.blue),
                          SizedBox(height: 10),
                          Text(
                            rooms[index]['name'],
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}