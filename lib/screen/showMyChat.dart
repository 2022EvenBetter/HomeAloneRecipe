import 'package:flutter/material.dart';
import 'package:home_alone_recipe/screen/myTown_screen.dart';
import 'package:provider/provider.dart';
import 'package:home_alone_recipe/provider/userProvider.dart';
import 'package:home_alone_recipe/widget/postStream.dart';
import 'package:home_alone_recipe/screen/postGroupBuying_screen.dart';
import 'package:home_alone_recipe/config/palette.dart';
import 'package:home_alone_recipe/widget/chatStream.dart';

class showMyChat extends StatefulWidget {
  const showMyChat({Key? key}) : super(key: key);

  @override
  State<showMyChat> createState() => _showMyChatState();
}

class _showMyChatState extends State<showMyChat> {
  late UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('채팅',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        elevation: 3.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Container(
        child: Stack(
          children:  [
          _userProvider.chats.isEmpty?
          Center(
              child:
                Text("아직 채팅이 없습니다.", style: TextStyle(fontSize: 18), ),
            ):
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Expanded(
                child: Chats(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
