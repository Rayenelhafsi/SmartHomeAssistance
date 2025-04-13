import 'package:flutter/material.dart';
import 'package:SmartHomeAssistance/services/database_service.dart';
import 'package:firebase_database/firebase_database.dart';

class houseconfig extends StatefulWidget {
  final String houseId; // Accept houseId as a parameter

  houseconfig({required this.houseId});

  @override
  _houseconfigState createState() => _houseconfigState();
}

class _houseconfigState extends State<houseconfig> {
  final DatabaseReference _database = DatabaseService().reference;

  final List<Map<String, dynamic>> rooms = [
    {'name': 'Kitchen', 'icon': Icons.kitchen, 'type': 'kitchen'},
    {'name': 'Bedroom', 'icon': Icons.bed, 'type': 'bedroom'},
    {'name': 'Toilet', 'icon': Icons.bathtub, 'type': 'bathroom'},
    {'name': 'Living Room', 'icon': Icons.weekend, 'type': 'livingRoom'},
  ];

  bool _isLoading = false; // Loading state
  Map<String, int> roomCounters = {}; // Room counters for each type

  @override
  void initState() {
    super.initState();
    _fetchRoomCounters();
  }

  void _fetchRoomCounters() async {
    final snapshot =
        await _database.child('houses/${widget.houseId}/roomCounters').get();
    if (snapshot.exists) {
      setState(() {
        roomCounters = Map<String, int>.from(snapshot.value as Map);
      });
    }
  }

  void _incrementRoom(String roomType) async {
    setState(() {
      roomCounters[roomType] = (roomCounters[roomType] ?? 0) + 1;
    });

    await _database
        .child('houses/${widget.houseId}/roomCounters/$roomType')
        .set(roomCounters[roomType]);
  }

  void _decrementRoom(String roomType) async {
    if ((roomCounters[roomType] ?? 0) > 0) {
      setState(() {
        roomCounters[roomType] = (roomCounters[roomType] ?? 0) - 1;
      });

      await _database
          .child('houses/${widget.houseId}/roomCounters/$roomType')
          .set(roomCounters[roomType]);
    }
  }

  void _confirmConfiguration() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Generate room names and save them to the database
      final Map<String, dynamic> roomsData = {};
      roomCounters.forEach((roomType, count) {
        for (int i = 1; i <= count; i++) {
          final roomName = "$roomType ${i.toString()}".replaceFirst(
            roomType[0],
            roomType[0].toUpperCase(),
          ); // Capitalize room type
          roomsData["$roomType$i"] = {
            'name': roomName,
            'devices': {}, // Initialize with no devices
          };
        }
      });

      await _database.child('houses/${widget.houseId}/rooms').set(roomsData);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Configuration confirmed!')));

      // Redirect to HomeScreen or any other screen
      Navigator.pop(context);
    } catch (e) {
      print("Error saving room configuration: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to save configuration.')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D0F1E),
      appBar: AppBar(
        backgroundColor: Color(0xFF0D0F1E),
        title: Text("Smart Home", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 40),
              SizedBox(
                width: 120,
                child: Image(
                  image: AssetImage('images/smart-home-assistance.png'),
                ),
              ),
              SizedBox(height: 40),

              // Room List Section
              Expanded(
                child: ListView.builder(
                  itemCount: rooms.length,
                  itemBuilder: (context, index) {
                    final room = rooms[index];
                    final roomType = room['type'];
                    final roomCount = roomCounters[roomType] ?? 0;

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Card(
                        color: Colors.deepPurple,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    room['icon'],
                                    size: 40,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    room['name'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () => _decrementRoom(roomType),
                                    icon: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '$roomCount',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => _incrementRoom(roomType),
                                    icon: Icon(Icons.add, color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Confirm Button
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: _confirmConfiguration,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Confirm Configuration",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_isLoading)
            Center(child: CircularProgressIndicator(color: Colors.white)),
        ],
      ),
    );
  }
}
