import 'package:SmartHomeAssistance/screens/homescreen.dart';
import 'package:SmartHomeAssistance/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class Room extends StatefulWidget {
  final String roomName;
  final int deviceCount;
  final String imageUrl;

  Room({
    super.key,
    required this.roomName,
    required this.deviceCount,
    required this.imageUrl,
  });

  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
  late final List<Map<String, dynamic>> devices;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    devices = [
      {'name': 'Lamp', 'icon': Icons.lightbulb_outline, 'status': true},
      {'name': 'AC', 'icon': Icons.ac_unit, 'status': false},
      {'name': 'Fan', 'icon': Icons.toys, 'status': true},
      {'name': 'Heater', 'icon': Icons.thermostat_rounded, 'status': false},
      {'name': 'TV', 'icon': Icons.tv, 'status': true},
      {'name': 'Speaker', 'icon': Icons.speaker, 'status': false},
      // You can add more devices here as needed
    ];
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/all_users');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/settings');
    }
  }

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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.roomName,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
          actions: [
            Icon(Icons.more_horiz_outlined, color: Colors.white),
            SizedBox(width: 20),
          ],
          backgroundColor: const Color.fromARGB(255, 20, 9, 48),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                children: [
                  Image.network(
                    widget.imageUrl,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: 200,
                  ),
                  Positioned(
                    bottom: 20,
                    right: 40,
                    child: Icon(
                      Icons.camera_enhance,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Devices',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two widgets per row
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: devices.length,
                  itemBuilder: (context, index) {
                    var device = devices[index];
                    return DeviceCard(device: device);
                  },
                ),
              ),
            ),
            BottomNavBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
          ],
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}

// Device Card Widget
class DeviceCard extends StatelessWidget {
  final Map<String, dynamic> device;

  DeviceCard({required this.device});

  @override
  Widget build(BuildContext context) {
    bool? isActive = device['status'];
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(device['icon'], size: 40, color: Colors.white),
          SizedBox(height: 8),
          Text(
            device['name'],
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          SizedBox(height: 8),
          if (isActive != null)
            Icon(
              isActive ? Icons.power : Icons.power_off,
              color: isActive ? Colors.blue : Colors.grey,
            ),
        ],
      ),
    );
  }
}
