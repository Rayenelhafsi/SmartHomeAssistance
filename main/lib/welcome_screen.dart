import 'package:SmartHomeAssistance/custom.dart';
import 'package:SmartHomeAssistance/houseID.dart';
import 'package:SmartHomeAssistance/posts/post1.dart';
import 'package:SmartHomeAssistance/posts/post2.dart';
import 'package:SmartHomeAssistance/posts/post3.dart';
import 'package:SmartHomeAssistance/posts/post4.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeScreen extends StatelessWidget {
final _controller=PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D0F1E) ,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 80,
            child: Image(
              image: AssetImage('images/smart-home-assistance.png'),
            // height: 120,
            // width: 120,
            ),
         ),
          SizedBox(
            height: 500,
            child:PageView(
            controller: _controller,
            children: [
              post1(),
              post2(),
              post3(),
              post4(),
            ],
          ), 
          ),
          SmoothPageIndicator(controller: _controller, count: 4, effect: ExpandingDotsEffect(
            activeDotColor: Colors.deepPurple,
            dotWidth: 30,
            dotHeight: 30,
            spacing: 30,
          ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Custom()),
              );
                      },
                      child: Text(
              'GO',
                      ),
                      ),
              SizedBox(
                width: 100,
              ),        
              FloatingActionButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => houseID()),
              );
                      },
                      child: Text(
              'SKIP',
                      ),
                      ),        
            ],
          ),
        ],
      ),
    );
  }
}