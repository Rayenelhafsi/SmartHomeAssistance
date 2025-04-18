import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'package:SmartHomeAssistance/services/database_service.dart';

class UserModel {
  final String uid;
  final String name;
  final String phone;
  final bool isActive;

  UserModel({
    required this.uid,
    required this.name,
    required this.phone,
    required this.isActive,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      isActive: map['isActive'] ?? true,
    );
  }
}

class AllUsersScreen extends StatefulWidget {
  final String homeId;
  final String currentUserUid;
  final String currentUserName;
  final String currentUserPhone;
  final String currentUserPhotoUrl;
  final bool currentUserIsActive;

  AllUsersScreen({
    required this.homeId,
    required this.currentUserUid,
    required this.currentUserName,
    required this.currentUserPhone,
    required this.currentUserPhotoUrl,
    required this.currentUserIsActive,
  });

  @override
  _AllUsersScreenState createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  List<UserModel> users = [];
  bool isLoading = true;

  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final userMaps = await DatabaseService.instance.getUsersByHomeId(
      widget.homeId,
    );

    // Add current user manually to ensure it's not duplicated in the list
    final currentUser = UserModel(
      uid: widget.currentUserUid,
      name: widget.currentUserName,
      phone: widget.currentUserPhone,
      isActive: widget.currentUserIsActive,
    );

    final allUsers = userMaps.map((map) => UserModel.fromMap(map)).toList();
    allUsers.add(currentUser); // Add current user manually in case not in DB

    // Remove duplicates by UID
    final uniqueUsers = <String, UserModel>{};
    for (var user in allUsers) {
      uniqueUsers[user.uid] = user; // overwrites duplicate uid
    }

    // Convert map back to list and filter out current user
    final filtered =
        uniqueUsers.values
            .where((user) => user.uid != widget.currentUserUid)
            .toList();

    setState(() {
      users = filtered;
      isLoading = false;
    });
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/settings');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('USERS LIST')),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 25.0,
                              backgroundImage:
                                  widget.currentUserPhotoUrl.isNotEmpty
                                      ? NetworkImage(widget.currentUserPhotoUrl)
                                      : AssetImage('images/anonym_icon.jpg')
                                          as ImageProvider,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color:
                                      widget.currentUserIsActive
                                          ? Colors.green
                                          : Colors.red,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.currentUserName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.currentUserPhone.isNotEmpty
                                  ? widget.currentUserPhone
                                  : 'No phone number',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey[300]),
                  Expanded(
                    child:
                        users.isEmpty
                            ? Center(
                              child: Text(
                                'No other users found for this home.',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                            : ListView.separated(
                              itemBuilder:
                                  (context, index) =>
                                      buildUserItem(users[index]),
                              separatorBuilder:
                                  (context, index) => Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                      start: 20.0,
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      height: 1.0,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                              itemCount: users.length,
                            ),
                  ),
                ],
              ),
      backgroundColor: const Color.fromARGB(255, 20, 9, 48),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget buildUserItem(UserModel user) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 25.0,
              child: Text(
                user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: user.isActive ? Colors.green : Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name.isNotEmpty ? user.name : 'Unnamed User',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              user.phone.isNotEmpty ? user.phone : 'No phone number',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ],
    ),
  );
}
