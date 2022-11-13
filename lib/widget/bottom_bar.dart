import 'package:flutter/material.dart';
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

class bottom_bar extends StatefulWidget {
  final _selectedIndex;
  final _onItemTapped;

  const bottom_bar(this._selectedIndex, this._onItemTapped, {super.key});

  @override
  State<bottom_bar> createState() => _bottom_barState();
}

class _bottom_barState extends State<bottom_bar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.cookie_sharp),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.handshake_sharp),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_rounded),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_sharp),
          label: '',
        ),
      ],
      currentIndex: widget._selectedIndex,
      selectedItemColor: Colors.amber[800],
      unselectedItemColor: Colors.grey,
      onTap: widget._onItemTapped,
    );
  }
}
