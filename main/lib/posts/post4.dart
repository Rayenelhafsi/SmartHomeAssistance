import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class post4 extends StatelessWidget {

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
                "CLICK GO AND LET'S START !",
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