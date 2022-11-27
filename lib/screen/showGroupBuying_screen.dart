import 'package:flutter/material.dart';
import 'package:home_alone_recipe/screen/myTown_screen.dart';
import 'package:provider/provider.dart';
import 'package:home_alone_recipe/provider/userProvider.dart';
import 'package:home_alone_recipe/widget/postStream.dart';
import 'package:home_alone_recipe/screen/postGroupBuying_screen.dart';
import 'package:home_alone_recipe/config/palette.dart';

class showGroupBuying extends StatefulWidget {
  const showGroupBuying({Key? key}) : super(key: key);

  @override
  State<showGroupBuying> createState() => _showGroupBuyingState();
}

class _showGroupBuyingState extends State<showGroupBuying> {
  late UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(_userProvider.locations[_userProvider.scope],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          elevation: 3.0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TownScreen()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left:10),
              child: Icon(
                Icons.update,
              ),
            ),
          ),
        ),
        body: Container(
            child: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Expanded(
              child: Posts(),
            ),
          ),
          Positioned(
            bottom: 15,
            right: 20,
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GroupBuying()),
                  );
                },
                icon: Icon(Icons.add_circle_outlined),
                iconSize: 65.0,
                color: Palette.blue),
          )
        ])));
  }
}
