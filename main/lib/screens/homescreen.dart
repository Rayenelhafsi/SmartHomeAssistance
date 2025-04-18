import 'package:flutter/material.dart';
import 'package:SmartHomeAssistance/screens/roomscreen.dart';
import 'package:SmartHomeAssistance/screens/profile.dart';
import 'package:SmartHomeAssistance/models/room.dart';
import 'package:SmartHomeAssistance/widgets/bottom_nav_bar.dart';
import 'package:SmartHomeAssistance/screens/all_users.dart';
import 'package:SmartHomeAssistance/screens/settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeScreen extends StatefulWidget {
  final DatabaseReference database;
  final User? currentUser;

  const HomeScreen({
    super.key,
    required this.database,
    required this.currentUser,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final DatabaseReference _database;
  late final User? _currentUser;

  int _selectedIndex = 0;
  String? _houseId;

  @override
  void initState() {
    super.initState();
    _database = widget.database;
    _currentUser = widget.currentUser;
    _fetchUserData();
  }

  String userName = "User";
  String houseName = "Your Home";
  String profileImage = 'images/anonym_icon.jpg'; // Default image
  List<Map<String, dynamic>> rooms = [];

  String _getRoomImage(String roomName) {
    final lowerName = roomName.toLowerCase();
    if (lowerName.contains('kitchen')) {
      return 'images/kitchen.jpg';
    } else if (lowerName.contains('bedroom')) {
      return 'images/bedroom.jpg';
    } else if (lowerName.contains('bathroom')) {
      return 'images/bathroom.jpg';
    } else if (lowerName.contains('living')) {
      return 'images/living-room.jpg';
    }
    return 'images/room.jpg'; // default
  }

  Future<void> _fetchUserData() async {
    if (_currentUser == null) return;

    try {
      // Fetch user data
      final userSnapshot =
          await _database.child('users/${_currentUser!.uid}').get();
      if (userSnapshot.exists) {
        final userData = Map<String, dynamic>.from(userSnapshot.value as Map);

        // Determine userName based on sign-in method
        if (_currentUser!.providerData.any(
          (provider) => provider.providerId == 'google.com',
        )) {
          userName = _currentUser!.email!.split('@')[0]; // Email without domain
        } else {
          userName = userData['name'] ?? "User"; // Use name from database
        }

        _houseId = userData['houseId'];
        print('Fetched houseId: $_houseId');

        // Fetch house data
        final houseSnapshot = await _database.child('houses/${_houseId}').get();
        if (houseSnapshot.exists) {
          final houseData = Map<String, dynamic>.from(
            houseSnapshot.value as Map,
          );
          houseName = houseData['houseName'] ?? "Your Home";

          // Fetch rooms and devices
          final roomsSnapshot =
              houseData['rooms'] as Map<dynamic, dynamic>? ?? {};
          rooms =
              roomsSnapshot.entries.map((entry) {
                final roomData = Map<String, dynamic>.from(entry.value as Map);
                return {
                  'name': roomData['name'],
                  'deviceCount':
                      (roomData['devices'] as Map<dynamic, dynamic>?)?.length ??
                      0,
                };
              }).toList();
        }
      }

      // Update profile image
      profileImage = _currentUser!.photoURL ?? 'images/anonym_icon.jpg';

      setState(() {});
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D0F1E), // Dark theme background
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          if (_selectedIndex == index) return;
          setState(() {
            _selectedIndex = index;
          });
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder:
                    (context) => HomeScreen(
                      database: _database,
                      currentUser: _currentUser,
                    ),
              ),
              (Route<dynamic> route) => false,
            );
          } else if (index == 1) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder:
                    (context) => AllUsersScreen(
                      homeId: _houseId ?? '',
                      currentUserName: userName,
                      currentUserPhone: _currentUser?.phoneNumber ?? '',
                      currentUserPhotoUrl: _currentUser?.photoURL ?? '',
                      currentUserIsActive: true,
                      currentUserUid: '', // Assuming current user is active
                    ),
              ),
              (Route<dynamic> route) => false,
            );
          } else if (index == 2) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
              (Route<dynamic> route) => false,
            );
          }
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section - User Greeting & Profile
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi $userName",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Welcome to $houseName",
                          style: TextStyle(color: Colors.white70),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            _currentUser?.phoneNumber ?? '',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 22,
                      backgroundImage:
                          _currentUser?.photoURL != null
                              ? NetworkImage(_currentUser!.photoURL!)
                              : AssetImage('images/anonym_icon.jpg')
                                  as ImageProvider,
                    ),
                  ],
                ),
              ),

              // Weather Panel
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WeatherCard(
                      icon: Icons.cloud,
                      label: "Outside",
                      temp: "22°C",
                    ),
                    WeatherCard(
                      icon: Icons.home,
                      label: "Indoor",
                      temp: "24°C",
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Navigation Icon
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.home, color: Colors.blue, size: 30),
              ),

              SizedBox(height: 20),

              // Room Cards Section
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Your Rooms",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: 200,
                    maxHeight: MediaQuery.of(context).size.height * 0.6,
                  ),
                  child:
                      rooms.isEmpty
                          ? Center(
                            child: Text(
                              "No rooms added yet.",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          )
                          : GridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            padding: EdgeInsets.only(bottom: 80),
                            children: List.generate(rooms.length, (index) {
                              final room = rooms[index];
                              return RoomCard(
                                imageUrl: _getRoomImage(room['name']),
                                roomName: room['name'],
                                deviceCount: room['deviceCount'],
                              );
                            }),
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget for Weather Cards
class WeatherCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String temp;

  const WeatherCard({
    super.key,
    required this.icon,
    required this.label,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFF1E1F2F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 30),
          SizedBox(height: 8),
          Text(label, style: TextStyle(color: Colors.white70, fontSize: 12)),
          SizedBox(height: 4),
          Text(
            temp,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// Widget for Small Room Cards
class RoomCard extends StatelessWidget {
  final String imageUrl;
  final String roomName;
  final int deviceCount;

  const RoomCard({
    super.key,
    required this.imageUrl,
    required this.roomName,
    required this.deviceCount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => Room(
                  roomName: roomName,
                  deviceCount: deviceCount,
                  imageUrl: imageUrl,
                ),
          ),
        );
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: Color(0xFF1E1F2F),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4),
                BlendMode.darken,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  roomName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "$deviceCount devices",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
