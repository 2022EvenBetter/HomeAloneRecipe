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
    if (_userProvider.locations.isNotEmpty) {
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
                padding: const EdgeInsets.only(left: 10),
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
                          MaterialPageRoute(
                              builder: (context) => GroupBuying()),
                        );
                      },
                      icon: Icon(Icons.add_circle_outlined),
                      iconSize: 65.0,
                      color: Palette.blue),
                )
              ])));
    }
    else {
      return Scaffold(
          body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Center(
                    child: Text('내 위치를 설정하지 않으면\n 이 페이지를 볼 수 없습니다!',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        textAlign: TextAlign.center),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),

                    child: OutlinedButton.icon(
                      // 텍스트버튼에 아이콘 넣기
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              const TownScreen()),
                        );
                      },
                      icon: const Icon(Icons.check_circle), // 아이콘 색
                      label: const Text('내 위치 설정하러 가기', style: TextStyle(
                          fontSize: 20) ),
                      style:  OutlinedButton.styleFrom(
                        // background 속성이 없다.
                          primary: Palette.blue,
                          side: BorderSide( // 테두리 바꾸는 속성
                            color: Palette.lightgrey,
                            width: 2.0,
                          )),// 글자 색
                    ),
                  )
                ],
              )));
    }
  }
}
