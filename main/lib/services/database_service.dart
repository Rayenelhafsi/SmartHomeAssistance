import 'package:firebase_database/firebase_database.dart';
import 'package:SmartHomeAssistance/models/room.dart'; // Assuming room.dart is a model

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  final DatabaseReference reference;

  factory DatabaseService() => _instance;

  DatabaseService._internal() : reference = FirebaseDatabase.instance.ref();

  static DatabaseService get instance => _instance;

  Future<List<Map<String, dynamic>>> getUsersByHomeId(String homeId) async {
    final userSnapshot =
        await reference
            .child('users')
            .orderByChild('houseId')
            .equalTo(homeId)
            .get();

    List<Map<String, dynamic>> usersWithPhone = [];

    if (userSnapshot.exists) {
      final usersMap = Map<String, dynamic>.from(userSnapshot.value as Map);
      for (var entry in usersMap.entries) {
        final user = Map<String, dynamic>.from(entry.value as Map);
        user['uid'] = entry.key;

        // Fetch house data to get the phone number
        final houseSnapshot =
            await reference.child('houses').child(user['houseId']).get();

        if (houseSnapshot.exists) {
          final houseData = Map<String, dynamic>.from(
            houseSnapshot.value as Map,
          );
          user['phone'] =
              houseData['phone'] ?? ''; // Add phone number to user data
        }

        usersWithPhone.add(user);
      }
      return usersWithPhone;
    } else {
      return [];
    }
  }
}
