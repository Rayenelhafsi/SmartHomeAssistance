import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  final DatabaseReference reference;

  factory DatabaseService() => _instance;

  DatabaseService._internal() : reference = FirebaseDatabase.instance.ref();

  static DatabaseService get instance => _instance;

  Future<List<Map<String, dynamic>>> getUsersByHomeId(String homeId) async {
    final snapshot =
        await reference
            .child('users')
            .orderByChild('houseId')
            .equalTo(homeId)
            .get();
    // Removed debug prints as requested
    if (snapshot.exists) {
      final usersMap = Map<String, dynamic>.from(snapshot.value as Map);
      return usersMap.entries.map((entry) {
        final user = Map<String, dynamic>.from(entry.value as Map);
        user['uid'] = entry.key;
        return user;
      }).toList();
    } else {
      return [];
    }
  }
}
