import 'package:flutter/material.dart';
import 'package:home_alone_recipe/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:home_alone_recipe/signup.dart';
import 'package:home_alone_recipe/home.dart';

class bottom_bar extends StatelessWidget {
  const bottom_bar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.yellow,
            width: 3.0,
          ),
        ),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: (){

              },
              icon: Icon(Icons.home)
          ),
          IconButton(
              onPressed: (){

              },
              icon: Icon(Icons.cookie_sharp)
          ),
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.handshake_sharp)
          ),
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.chat)
          ),
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.people_sharp)
          )
        ],
      )
    );
  }
}
