import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_alone_recipe/widget/bottom_bar.dart';

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
        title: const Text('마이냉장고'),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.exit_to_app_sharp,
                color: Colors.black,
              ),
              onPressed: () {
                _authentication.signOut();
                Navigator.pop(context);
              })
        ],
      ),
      body: const Center(
        child: Text('홈화면'),
      ),
      bottomNavigationBar: const bottom_bar(),
    );
  }
}
