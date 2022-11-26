import 'package:flutter/material.dart';
import 'package:home_alone_recipe/screen/postGroupBuying_screen.dart';
import 'package:home_alone_recipe/screen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:home_alone_recipe/screen/signup_screen.dart';
import 'package:home_alone_recipe/screen/home_screen.dart';

class BottomBar extends StatefulWidget {
  final _selectedIndex;
  final _onItemTapped;
  const BottomBar(this._selectedIndex, this._onItemTapped, {Key? key})
      : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '홈화면',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.cookie_sharp),
          label: '레시피화면',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.handshake_sharp),
          label: '공동구매화면',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_rounded),
          label: '채팅화면',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_sharp),
          label: '유저화면',
        ),
      ],
      currentIndex: widget._selectedIndex,
      selectedItemColor: Colors.amber[800],
      unselectedItemColor: Colors.grey,
      onTap: widget._onItemTapped,
    );
  }
}
