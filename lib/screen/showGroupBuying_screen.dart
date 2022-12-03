import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_alone_recipe/widget/api.dart';
import 'package:home_alone_recipe/screen/myTown_screen.dart';
import 'package:home_alone_recipe/widget/ingredient_filter.dart';
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
  Map<String, dynamic> ingMap = {
    "소고기": ["쇠고기"],
    "닭고기": ["닭", "닭다리"],
  };

  late UserProvider _userProvider;
  bool showWidget = false;
  String ingredientArr = "";
  FirebaseFirestore db = FirebaseFirestore.instance;

  bool isScrapped = false;

  void changeIng(String name) {
    setState(() {
      ingredientArr = name;
      print(ingredientArr);
    });
  }

  void rmvIng() {}

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
            Container(
              height: 1000,
              child: Column(
                children: [
                  IngredientFilter(changeIng, rmvIng),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          spreadRadius: 0,
                          blurRadius: 2,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    height: 1.0,
                    width: 500.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ingredientArr != ""
                          ? Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Palette.blue),
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  '${ingredientArr}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          : Text(''),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            ingredientArr = "";
                          });
                        },
                        icon: Icon(Icons.refresh_outlined),
                        style: IconButton.styleFrom(
                            shape: CircleBorder(),
                            foregroundColor: Palette.yellow,
                            backgroundColor: Palette.yellow),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          spreadRadius: 0,
                          blurRadius: 2,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    height: 1.0,
                    width: 500.0,
                  ),
                  Expanded(
                    child: Posts(ingredientArr),
                  ),
                ],
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
    } else {
      return Scaffold(
          body: Container(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                  MaterialPageRoute(builder: (context) => const TownScreen()),
                );
              },
              icon: const Icon(Icons.check_circle), // 아이콘 색
              label: const Text('내 위치 설정하러 가기', style: TextStyle(fontSize: 20)),
              style: OutlinedButton.styleFrom(
                  // background 속성이 없다.
                  primary: Palette.blue,
                  side: BorderSide(
                    // 테두리 바꾸는 속성
                    color: Palette.lightgrey,
                    width: 2.0,
                  )), // 글자 색
            ),
          )
        ],
      )));
    }
  }
}
