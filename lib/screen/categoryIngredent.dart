import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;
import 'package:home_alone_recipe/widget/getRecipe.dart';
import 'package:home_alone_recipe/models/recipe.dart';

class CategoryIngredient extends StatefulWidget {
  const CategoryIngredient({super.key});

  @override
  State<CategoryIngredient> createState() => _CategoryIngredientState();
}

class _CategoryIngredientState extends State<CategoryIngredient> {
  bool _hasBeenPressed = false;
  bool _visibility = false;
  List<String> seletecIngredients = [];

  void _setVisibility() {
    setState(() {
      _visibility = !_visibility;
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
                      CategoryContainer(() => _setVisibility(), _visibility),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Visibility(
                          maintainState: true,
                          child: Wrap(children: [
                            IngredientButton("소고기", seletecIngredients),
                            IngredientButton("돼지고기", seletecIngredients),
                            IngredientButton("양고기", seletecIngredients),
                            IngredientButton("오리고기", seletecIngredients),
                            IngredientButton("닭고기", seletecIngredients),
                            IngredientButton("닭고기", seletecIngredients),
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
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 10.0),
                              child: Row(
                                children: [
                                  Text(
                                    '육류',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _visibility = !_visibility;
                                        });
                                      },
                                      icon: _visibility
                                          ? Icon(Icons.arrow_upward)
                                          : Icon(Icons.arrow_downward)),
                                ],
                              )),
                          Wrap(children: <Widget>[
                            IngredientButton("모듬채소", seletecIngredients),
                            IngredientButton("배추", seletecIngredients),
                            IngredientButton("양배추", seletecIngredients),
                            IngredientButton("buttonName", seletecIngredients),
                            IngredientButton("buttonName1", seletecIngredients)
                          ]),
                        ],
                      )),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(children: <Widget>[
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            '육류',
                            style: TextStyle(fontSize: 20.0),
                          )),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Wrap(children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                              child: ElevatedButton(
                                child: Text("돼지고기"),
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    minimumSize: Size(70, 70)),
                              )),
                          Container(
                              margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                              child: ElevatedButton(
                                child: Text("돼지고기"),
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    minimumSize: Size(70, 70)),
                              )),
                          Container(
                              margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                              child: ElevatedButton(
                                child: Text("돼지고기"),
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    minimumSize: Size(70, 70)),
                              )),
                          Container(
                              margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                              child: ElevatedButton(
                                child: Text("돼지고기"),
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    minimumSize: Size(70, 70)),
                              )),
                          Container(
                              margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                              child: ElevatedButton(
                                child: Text("돼지고기"),
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    minimumSize: Size(70, 70)),
                              )),
                        ]),
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

class IngredientButton extends StatefulWidget {
  final String buttonName;
  final List<String> selectedIngedient;
  const IngredientButton(this.buttonName, this.selectedIngedient, {super.key});

  @override
  State<IngredientButton> createState() => _IngredientButtonState();
}

class _IngredientButtonState extends State<IngredientButton> {
  bool _hasBeenPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
        child: ElevatedButton(
          child: Image.asset(
            'lib/assets/icons/cabage.png',
            scale: 10,
            color: _hasBeenPressed
                ? Colors.white.withOpacity(1)
                : Colors.white.withOpacity(0.4),
            colorBlendMode: BlendMode.modulate,
          ),
          onPressed: () {
            setState(() {
              _hasBeenPressed = !_hasBeenPressed;
              if (_hasBeenPressed) {
                widget.selectedIngedient.add(widget.buttonName);
              } else {
                widget.selectedIngedient.remove(widget.buttonName);
              }
              print('hello');
            });
          },
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            minimumSize: Size(70, 70),
            backgroundColor: Colors.white,
            shadowColor: Colors.white,
          ),
        ));
  }
}

class CategoryContainer extends StatefulWidget {
  final Function() isVisible;
  final bool visibility;
  const CategoryContainer(this.isVisible, this.visibility, {super.key});

  @override
  State<CategoryContainer> createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 10.0),
        child: Row(
          children: [
            Text(
              '육류',
              style: TextStyle(fontSize: 20.0),
            ),
            IconButton(
                onPressed: () {
                  widget.isVisible();
                },
                icon: widget.visibility
                    ? Icon(Icons.arrow_upward)
                    : Icon(Icons.arrow_downward)),
          ],
        ));
  }
}
