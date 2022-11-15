import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_alone_recipe/groupBuying.dart';
import 'package:home_alone_recipe/widget/bottomBar.dart';
import 'ocr.dart';
import 'widget/getRecipe.dart';
import 'screen/recipe_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;

  // bottom bar info
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    ocr(),
    RecipeScreen(),
    GroupBuying(),
    Text(
      '채팅화면',
      style: optionStyle,
    ),
    Text(
      '유저화면',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
        title: Text('마이냉장고'),
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
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomBar(_selectedIndex, _onItemTapped),
    );
  }
}
