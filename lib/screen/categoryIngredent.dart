import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        title: Text('카테고리로 재료추가'),
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
                                    "채소류", "감자", seletecIngredients),
                                IngredientButton(
                                    "채소류", "고추", seletecIngredients),
                                IngredientButton(
                                    "채소류", "당근", seletecIngredients),
                                IngredientButton(
                                    "채소류", "마늘", seletecIngredients),
                                IngredientButton(
                                    "채소류", "바질", seletecIngredients),
                                IngredientButton(
                                    "채소류", "배추", seletecIngredients),
                                IngredientButton(
                                    "채소류", "버섯", seletecIngredients),
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
                          child: Wrap(children: []),
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
                          child: Wrap(children: []),
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
                          child: Wrap(children: []),
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
                          child: Wrap(children: []),
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
                            IngredientButton("과일", "건포도", seletecIngredients),
                            IngredientButton("과일", "딸기", seletecIngredients),
                            IngredientButton("과일", "레몬", seletecIngredients),
                            IngredientButton("과일", "바나나", seletecIngredients),
                            IngredientButton("과일", "배", seletecIngredients),
                            IngredientButton("과일", "사과", seletecIngredients),
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
                          child: Wrap(children: []),
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
                          child: Wrap(children: []),
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
                          child: Wrap(children: []),
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
                          child: Wrap(children: []),
                          visible: _visibility10,
                        ),
                      )
                    ]),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                print(seletecIngredients);
                Navigator.pop(context, seletecIngredients);
              },
              child: Text('추가하기')),
        ],
      ),
    );
  }
}
