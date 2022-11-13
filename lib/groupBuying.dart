import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_alone_recipe/widget/bottomBar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:home_alone_recipe/models/post.dart';

class GroupBuying extends StatefulWidget {
  const GroupBuying({Key? key}) : super(key: key);

  @override
  State<GroupBuying> createState() => _GroupBuyingState();
}

class _GroupBuyingState extends State<GroupBuying> {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  final List<String> upperCategoryList = ['육류', '야채류', '소스류', '유제품'];
  String selectedUpper = '육류';
  final List<String> lowerCategoryList = ['돼지고기', '닭고기', '우유', '양상추', '굴소스'];
  String selectedLower = '돼지고기';
  String? inputTitle = '';
  //static Post post; //사용자가 입력한 정보를 담을 객체

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('글쓰기'),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ListView(
          padding: const EdgeInsets.fromLTRB(20.0, 40.0, 0.0, 0.0),
          children: <Widget>[
            const Text(
              '상위 카테고리',
              style: TextStyle(
                letterSpacing: 1.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButton(
                value: selectedUpper, //초기값 설정
                items: upperCategoryList.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedUpper = value!;
                  });
                }),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              '하위 카테고리',
              style: TextStyle(
                letterSpacing: 1.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButton(
                value: selectedLower,
                items: lowerCategoryList.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedLower = value!;
                  });
                }),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              '제목',
              style: TextStyle(
                letterSpacing: 1.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
                decoration: const InputDecoration(
                  hintText: '제목을 입력해주세요.',
                ),
                onChanged: (text) {}),
          ]),
    );
  }
}
