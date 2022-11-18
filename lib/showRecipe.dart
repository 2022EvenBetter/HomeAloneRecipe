import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_alone_recipe/widget/bottomBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('전체레시피 조회'),
        actions: [
          IconButton(
              icon: Icon(
                Icons.exit_to_app_sharp,
                color: Colors.black,
              ),
              onPressed: () {
                _authentication.signOut();
                Navigator.pop(context);
              })
        ],
      ),
      body: Center(
        child: Text('레시피화면2'),
      ),
    );
  }
}