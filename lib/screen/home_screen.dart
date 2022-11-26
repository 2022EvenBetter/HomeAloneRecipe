import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_alone_recipe/screen/postGroupBuying_screen.dart';
import 'package:home_alone_recipe/screen/myTown_screen.dart';
import 'package:home_alone_recipe/screen/groupChatting.dart';
import 'package:home_alone_recipe/widget/bottomBar.dart';
import 'ocr.dart';
import '../widget/getRecipe.dart';
import 'recipe_screen.dart';

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
    MessageListScreen(),
    TownScreen(),
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

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomBar(_selectedIndex, _onItemTapped),
    );
  }
}
