import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_alone_recipe/config/palette.dart';
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;
import 'package:home_alone_recipe/widget/getRecipe.dart';
import 'package:home_alone_recipe/models/recipe.dart';

import 'package:home_alone_recipe/widget/category_container.dart';
import 'package:home_alone_recipe/widget/ingredient_button.dart';

class CategoryIngredient extends StatefulWidget {
  const CategoryIngredient({super.key});

  @override
  State<CategoryIngredient> createState() => _CategoryIngredientState();
}

class _CategoryIngredientState extends State<CategoryIngredient> {
  bool _hasBeenPressed = false;
  bool _visibility = true;
  bool _visibility1 = false;
  bool _visibility2 = false;
  bool _visibility3 = false;
  bool _visibility4 = false;
  bool _visibility5 = false;
  bool _visibility6 = false;
  bool _visibility7 = false;
  bool _visibility8 = false;
  bool _visibility9 = false;
  bool _visibility10 = false;

  List<String> seletecIngredients = [];

  void _setVisibility() {
    setState(() {
      _visibility = !_visibility;
    });
  }

  void _setVisibility1() {
    setState(() {
      _visibility1 = !_visibility1;
    });
  }

  void _setVisibility2() {
    setState(() {
      _visibility2 = !_visibility2;
    });
  }

  void _setVisibility3() {
    setState(() {
      _visibility3 = !_visibility3;
    });
  }

  void _setVisibility4() {
    setState(() {
      _visibility4 = !_visibility4;
    });
  }

  void _setVisibility5() {
    setState(() {
      _visibility5 = !_visibility5;
    });
  }

  void _setVisibility6() {
    setState(() {
      _visibility6 = !_visibility6;
    });
  }

  void _setVisibility7() {
    setState(() {
      _visibility7 = !_visibility7;
    });
  }

  void _setVisibility8() {
    setState(() {
      _visibility8 = !_visibility8;
    });
  }

  void _setVisibility9() {
    setState(() {
      _visibility9 = !_visibility9;
    });
  }

  void _setVisibility10() {
    setState(() {
      _visibility10 = !_visibility10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '카테고리로 재료추가',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 3.0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(children: <Widget>[
                      CategoryContainer(
                          "육류", () => _setVisibility(), _visibility),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Visibility(
                          maintainState: true,
                          child:
                              Wrap(alignment: WrapAlignment.start, children: [
                            IngredientButton("육류", "소고기", seletecIngredients),
                            IngredientButton("육류", "돼지고기", seletecIngredients),
                            IngredientButton("육류", "닭고기", seletecIngredients),
                            IngredientButton("육류", "곱창", seletecIngredients),
                            IngredientButton("육류", "다짐육", seletecIngredients),
                          ]),
                          visible: _visibility,
                        ),
                      )
                    ]),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(children: <Widget>[
                      CategoryContainer(
                          "채소류", () => _setVisibility1(), _visibility1),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Visibility(
                          maintainState: true,
                          child: Wrap(
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.start,
                              children: [
                                IngredientButton(
                                    "채소류", "가지", seletecIngredients),
                                IngredientButton(
                                    "채소류", "고추", seletecIngredients),
                                IngredientButton(
                                    "채소류", "김치", seletecIngredients),
                                IngredientButton(
                                    "채소류", "대파", seletecIngredients),
                                IngredientButton(
                                    "채소류", "당근", seletecIngredients),
                                IngredientButton(
                                    "채소류", "마늘", seletecIngredients),
                                IngredientButton(
                                    "채소류", "무", seletecIngredients),
                                IngredientButton(
                                    "채소류", "배추", seletecIngredients),
                                IngredientButton(
                                    "채소류", "양송이버섯", seletecIngredients),
                                IngredientButton(
                                    "채소류", "양배추", seletecIngredients),
                                IngredientButton(
                                    "채소류", "양파", seletecIngredients),
                                IngredientButton(
                                    "채소류", "오이", seletecIngredients),
                                IngredientButton(
                                    "채소류", "콩나물", seletecIngredients),
                                IngredientButton(
                                    "채소류", "토마토", seletecIngredients),
                                IngredientButton(
                                    "채소류", "파프리카", seletecIngredients),
                                IngredientButton(
                                    "채소류", "호박", seletecIngredients),
                                IngredientButton(
                                    "채소류", "팽이버섯", seletecIngredients),
                                IngredientButton(
                                    "채소류", "표고버섯", seletecIngredients),
                                IngredientButton(
                                    "채소류", "브로콜리", seletecIngredients),
                                IngredientButton(
                                    "채소류", "비트", seletecIngredients),
                                IngredientButton(
                                    "채소류", "상추", seletecIngredients),
                                IngredientButton(
                                    "채소류", "샐러리", seletecIngredients),
                              ]),
                          visible: _visibility1,
                        ),
                      )
                    ]),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(children: <Widget>[
                      CategoryContainer(
                          "해산물", () => _setVisibility2(), _visibility2),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Visibility(
                          maintainState: true,
                          child: Wrap(children: [
                            IngredientButton("해산물", "갈치", seletecIngredients),
                            IngredientButton("해산물", "게맛살", seletecIngredients),
                            IngredientButton("해산물", "고등어", seletecIngredients),
                            IngredientButton("해산물", "골뱅이", seletecIngredients),
                            IngredientButton("해산물", "굴", seletecIngredients),
                            IngredientButton("해산물", "꽁치", seletecIngredients),
                            IngredientButton("해산물", "낙지", seletecIngredients),
                            IngredientButton("해산물", "다시마", seletecIngredients),
                            IngredientButton("해산물", "새우", seletecIngredients),
                            IngredientButton("해산물", "동태", seletecIngredients),
                            IngredientButton("해산물", "멸치", seletecIngredients),
                            IngredientButton("해산물", "문어", seletecIngredients),
                            IngredientButton("해산물", "미역", seletecIngredients),
                            IngredientButton("해산물", "조개", seletecIngredients),
                            IngredientButton("해산물", "오징어", seletecIngredients),
                            IngredientButton("해산물", "전복", seletecIngredients),
                            IngredientButton("해산물", "조기", seletecIngredients),
                            IngredientButton("해산물", "쭈꾸미", seletecIngredients),
                          ]),
                          visible: _visibility2,
                        ),
                      )
                    ]),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(children: <Widget>[
                      CategoryContainer(
                          "곡류", () => _setVisibility3(), _visibility3),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Visibility(
                          maintainState: true,
                          child: Wrap(children: [
                            IngredientButton("곡류", "감자", seletecIngredients),
                            IngredientButton("곡류", "고구마", seletecIngredients),
                            IngredientButton("곡류", "밀가루", seletecIngredients),
                            IngredientButton("곡류", "빵가루", seletecIngredients),
                            IngredientButton("곡류", "부침가루", seletecIngredients),
                            IngredientButton("곡류", "옥수수", seletecIngredients),
                            IngredientButton("곡류", "찹쌀가루", seletecIngredients),
                            IngredientButton("곡류", "쌀", seletecIngredients),
                          ]),
                          visible: _visibility3,
                        ),
                      )
                    ]),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(children: <Widget>[
                      CategoryContainer(
                          "가공/유제품", () => _setVisibility4(), _visibility4),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Visibility(
                          maintainState: true,
                          child: Wrap(children: [
                            IngredientButton("가공유제품", "계란", seletecIngredients),
                            IngredientButton(
                                "가공유제품", "참치캔", seletecIngredients),
                            IngredientButton(
                                "가공유제품", "모짜렐라치즈", seletecIngredients),
                            IngredientButton(
                                "가공유제품", "슬라이스치즈", seletecIngredients),
                            IngredientButton(
                                "가공유제품", "옥수수콘", seletecIngredients),
                            IngredientButton("가공유제품", "버터", seletecIngredients),
                            IngredientButton("가공유제품", "우유", seletecIngredients),
                            IngredientButton("가공유제품", "어묵", seletecIngredients),
                          ]),
                          visible: _visibility4,
                        ),
                      )
                    ]),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(children: <Widget>[
                      CategoryContainer(
                          "콩/견과류", () => _setVisibility5(), _visibility5),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Visibility(
                          maintainState: true,
                          child: Wrap(children: [
                            IngredientButton("콩견과류", "깨", seletecIngredients),
                            IngredientButton("콩견과류", "두부", seletecIngredients),
                            IngredientButton("콩견과류", "콩", seletecIngredients),
                            IngredientButton("콩견과류", "아몬드", seletecIngredients),
                            IngredientButton("콩견과류", "호두", seletecIngredients),
                            IngredientButton("콩견과류", "청국장", seletecIngredients),
                          ]),
                          visible: _visibility5,
                        ),
                      )
                    ]),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(children: <Widget>[
                      CategoryContainer(
                          "과일", () => _setVisibility6(), _visibility6),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Visibility(
                          maintainState: true,
                          child: Wrap(children: [
                            IngredientButton("과일", "감", seletecIngredients),
                            IngredientButton("과일", "건포도", seletecIngredients),
                            IngredientButton("과일", "딸기", seletecIngredients),
                            IngredientButton("과일", "레몬", seletecIngredients),
                            IngredientButton("과일", "바나나", seletecIngredients),
                            IngredientButton("과일", "배", seletecIngredients),
                            IngredientButton("과일", "사과", seletecIngredients),
                            IngredientButton("과일", "아보카도", seletecIngredients),
                            IngredientButton("과일", "오렌지", seletecIngredients),
                            IngredientButton("과일", "체리", seletecIngredients),
                            IngredientButton("과일", "키위", seletecIngredients),
                            IngredientButton("과일", "파인애플", seletecIngredients),
                            IngredientButton("과일", "포도", seletecIngredients),
                          ]),
                          visible: _visibility6,
                        ),
                      )
                    ]),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(children: <Widget>[
                      CategoryContainer(
                          "면", () => _setVisibility7(), _visibility7),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Visibility(
                          maintainState: true,
                          child: Wrap(children: [
                            IngredientButton("면", "칼국수면", seletecIngredients),
                            IngredientButton("면", "파스타면", seletecIngredients),
                            IngredientButton("면", "우동면", seletecIngredients),
                            IngredientButton("면", "소면", seletecIngredients),
                            IngredientButton("면", "당면", seletecIngredients),
                            IngredientButton("면", "라면", seletecIngredients),
                          ]),
                          visible: _visibility7,
                        ),
                      )
                    ]),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(children: <Widget>[
                      CategoryContainer(
                          "빵/떡", () => _setVisibility8(), _visibility8),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Visibility(
                          maintainState: true,
                          child: Wrap(children: [
                            IngredientButton("빵떡", "식빵", seletecIngredients),
                            IngredientButton("빵떡", "떡국떡", seletecIngredients),
                          ]),
                          visible: _visibility8,
                        ),
                      )
                    ]),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(children: <Widget>[
                      CategoryContainer(
                          "햄/소시지", () => _setVisibility9(), _visibility9),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Visibility(
                          maintainState: true,
                          child: Wrap(children: [
                            IngredientButton("햄소시지", "베이컨", seletecIngredients),
                            IngredientButton(
                                "햄소시지", "비엔나소시지", seletecIngredients),
                            IngredientButton("햄소시지", "소시지", seletecIngredients),
                            IngredientButton("햄소시지", "햄", seletecIngredients),
                          ]),
                          visible: _visibility9,
                        ),
                      )
                    ]),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(children: <Widget>[
                      CategoryContainer(
                          "조미료/양념", () => _setVisibility10(), _visibility10),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Visibility(
                          maintainState: true,
                          child: Wrap(children: [
                            IngredientButton("조미료양념", "간장", seletecIngredients),
                            IngredientButton(
                                "조미료양념", "고추장", seletecIngredients),
                            IngredientButton(
                                "조미료양념", "고춧가루", seletecIngredients),
                            IngredientButton(
                                "조미료양념", "굴소스", seletecIngredients),
                            IngredientButton("조미료양념", "소금", seletecIngredients),
                            IngredientButton(
                                "조미료양념", "다진마늘", seletecIngredients),
                            IngredientButton(
                                "조미료양념", "멸치액젓", seletecIngredients),
                            IngredientButton("조미료양념", "설탕", seletecIngredients),
                            IngredientButton("조미료양념", "식초", seletecIngredients),
                            IngredientButton("조미료양념", "쌈장", seletecIngredients),
                            IngredientButton(
                                "조미료양념", "올리브유", seletecIngredients),
                            IngredientButton("조미료양념", "케첩", seletecIngredients),
                            IngredientButton(
                                "조미료양념", "마요네즈", seletecIngredients),
                            IngredientButton("조미료양념", "후추", seletecIngredients),
                            IngredientButton(
                                "조미료양념", "쇠고기 다시다", seletecIngredients),
                            IngredientButton(
                                "조미료양념", "카레가루", seletecIngredients),
                            IngredientButton(
                                "조미료양념", "참기름", seletecIngredients),
                            IngredientButton("조미료양념", "된장", seletecIngredients),
                          ]),
                          visible: _visibility10,
                        ),
                      )
                    ]),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom:5),
            child: SizedBox(
              height: MediaQuery.of(context).size.width*0.1,
              width: MediaQuery.of(context).size.width*0.9,
              child: ElevatedButton(
                  onPressed: () {
                    print(seletecIngredients);
                    Navigator.pop(context, seletecIngredients);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Palette.orange, // Background color
                    onPrimary: Colors.white,// Text Color (Foreground color)
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                  ),

                  child: Text('추가하기', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,),),
            ),
          ),
          ),],
      ),
    );
  }
}
