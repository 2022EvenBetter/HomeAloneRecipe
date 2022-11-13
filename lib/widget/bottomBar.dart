import 'package:flutter/material.dart';
import 'package:home_alone_recipe/groupBuying.dart';
import 'package:home_alone_recipe/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:home_alone_recipe/signup.dart';
import 'package:home_alone_recipe/home.dart';

// class bottom_bar1 extends StatelessWidget {
//   const bottom_bar({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: Colors.yellow,
//             width: 3.0,
//           ),
//         ),
//         child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           IconButton(
//               onPressed: (){

//               },
//               icon: Icon(Icons.home)
//           ),
//           IconButton(
//               onPressed: (){

//               },
//               icon: Icon(Icons.cookie_sharp)
//           ),
//           IconButton(
//               onPressed: (){},
//               icon: Icon(Icons.handshake_sharp)
//           ),
//           IconButton(
//               onPressed: (){},
//               icon: Icon(Icons.chat)
//           ),
//           IconButton(
//               onPressed: (){},
//               icon: Icon(Icons.people_sharp)
//           )
//         ],
//       )
//     );
//   }
// }

class BottomBar extends StatefulWidget {
  final _selectedIndex;
  final _onItemTapped;
  const BottomBar(this._selectedIndex, this._onItemTapped, {Key? key})
      : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const HomeScreen(),
    const GroupBuying(),
    const HomeScreen(),
    const HomeScreen(),
  ];

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
