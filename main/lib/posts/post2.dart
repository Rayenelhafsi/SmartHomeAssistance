import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class post2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent ,
      body: Padding(
        padding: EdgeInsets.all(40),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            child: Center(
              child: Text(
                'ARE YOU READY TO CUSTOMIZE YOUR EXPERIENCE ?',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ), 
        ),
    );
  }
}