import 'package:flutter/material.dart';

class UserModel {
  final int id;
  final String name;
  final String phone;

  UserModel({
    required this.id,
    required this.phone,
    required this.name,
  });
}

// ignore: must_be_immutable
class UsersScreen extends StatelessWidget {
  List<UserModel> users = [
    UserModel(
      id: 1,
      name: 'User 1',
      phone: '**********',
    ),
    UserModel(
      id: 2,
      name: 'User 2',
      phone: '**********',
    ),
    UserModel(
      id: 3,
      name: 'User 3',
      phone: '**********',
    ),
    UserModel(
      id: 4,
      name: 'User 4',
      phone: '**********',
    ),
    UserModel(
      id: 5,
      name: 'User 5',
      phone: '**********',
    ),
    UserModel(
      id: 6,
      name: 'User 6',
      phone: '**********',
    ),
    UserModel(
      id: 7,
      name: 'User 7',
      phone: '**********',
    ),
    UserModel(
      id: 8,
      name: 'User 8',
      phone: '**********',
    ),
    UserModel(
      id: 9,
      name: 'User 9',
      phone: '**********',
    ),
        UserModel(
      id: 10,
      name: 'User 10',
      phone: '**********',
    ),
    UserModel(
      id: 11,
      name: 'User 11',
      phone: '**********',
    ),
    UserModel(
      id: 12,
      name: 'User 12',
      phone: '**********',
    ),
    UserModel(
      id: 13,
      name: 'User 13',
      phone: '**********',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'USERS LIST',
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => buildUserItem(users[index]),
        separatorBuilder: (context, index) => Padding(
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
      backgroundColor: const Color.fromARGB(255, 20, 9, 48),
    );
  }

  Widget buildUserItem(UserModel user) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              child: Text(
                '${user.id}',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.name}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${user.phone}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      );


}