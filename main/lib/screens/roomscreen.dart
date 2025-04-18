import 'package:flutter/material.dart';

class RoomScreen extends StatelessWidget {
  final String imageUrl;
  final String roomName;
  final int deviceCount;

  const RoomScreen({
    super.key,
    required this.imageUrl,
    required this.roomName,
    required this.deviceCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(roomName)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(imageUrl, height: 200),
            const SizedBox(height: 20),
            Text('Room: $roomName'),
            const SizedBox(height: 10),
            Text('Devices: $deviceCount'),
          ],
        ),
      ),
    );
  }
}
