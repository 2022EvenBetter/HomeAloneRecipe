import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_alone_recipe/screen/home_screen.dart';
import 'package:home_alone_recipe/models/post.dart';
import 'package:provider/provider.dart';
import 'package:home_alone_recipe/provider/userProvider.dart';
import 'package:home_alone_recipe/constants/category.dart';
import 'package:home_alone_recipe/widget/postStream.dart';
import 'package:home_alone_recipe/screen/postGroupBuying_screen.dart';


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
        title: Text(_userProvider.locations[2], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        elevation: 3.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body:Container(
        child:Column(
          children:[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GroupBuying()),
                );
              },
              child: Text('공동구매 글을 작성하세요!'),
            ),
            Expanded(
              child: Posts(),
            )
          ]
        )
      )
    );
  }

}