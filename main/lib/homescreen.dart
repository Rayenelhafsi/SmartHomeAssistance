import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D0F1E), // Dark theme background
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section - User Greeting & Profile
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi Kiki",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Welcome to kk'home",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(
                      "https://via.placeholder.com/150", // Replace with actual profile image
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Weather & Temperature Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WeatherCard(icon: Icons.cloud, label: "Raining", temp: "--"),
                  WeatherCard(
                      icon: Icons.thermostat,
                      label: "Temp Outside",
                      temp: "28°C"),
                  WeatherCard(
                      icon: Icons.ac_unit, label: "Temp Indoor", temp: "18°C"),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Small Room Cards (Horizontal Scroll)
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 20),
                children: [
                  RoomCard(
                    imageUrl: "https://via.placeholder.com/300",
                    roomName: "Bedroom",
                    deviceCount: 3,
                  ),
                  RoomCard(
                    imageUrl: "https://via.placeholder.com/300",
                    roomName: "Living Room",
                    deviceCount: 6,
                  ),
                  RoomCard(
                    imageUrl: "https://via.placeholder.com/300",
                    roomName: "Kitchen",
                    deviceCount: 4,
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            // Music Player & Bottom Navigation
            MusicPlayer(),

            BottomNavBar(),
          ],
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

  const WeatherCard(
      {super.key, required this.icon, required this.label, required this.temp});

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
          Text(temp,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
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

  const RoomCard(
      {super.key,
      required this.imageUrl,
      required this.roomName,
      required this.deviceCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140, // Small width
      height: 80, // Small height
      margin: EdgeInsets.only(right: 12), // Spacing between cards
      decoration: BoxDecoration(
        color: Color(0xFF1E1F2F),
        borderRadius: BorderRadius.circular(12), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(12), // Compact padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              roomName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14, // Smaller font size
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "$deviceCount DEVICES",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 10, // Smaller font size
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Music Player Widget
class MusicPlayer extends StatelessWidget {
  const MusicPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF1E1F2F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.play_circle_fill, color: Colors.blue, size: 36),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("FOLLOW HRART", style: TextStyle(color: Colors.white)),
              Text("04:32",
                  style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
          Row(
            children: [
              Icon(Icons.pause, color: Colors.white),
              SizedBox(width: 10),
              Icon(Icons.skip_next, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}

// Bottom Navigation Bar
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xFF1E1F2F),
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.white70,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "HOME"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "USERS"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "SETTINGS"),
      ],
    );
  }
}
