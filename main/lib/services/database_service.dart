import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  final DatabaseReference reference;

  factory DatabaseService() => _instance;

  DatabaseService._internal() : reference = FirebaseDatabase.instance.ref();

  static DatabaseService get instance => _instance;
}
