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
          '??????????????? ????????????',
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
                          "??????", () => _setVisibility(), _visibility),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Visibility(
                          maintainState: true,
                          child:
                              Wrap(alignment: WrapAlignment.start, children: [
                            IngredientButton("??????", "?????????", seletecIngredients),
                            IngredientButton("??????", "????????????", seletecIngredients),
                            IngredientButton("??????", "?????????", seletecIngredients),
                            IngredientButton("??????", "??????", seletecIngredients),
                            IngredientButton("??????", "?????????", seletecIngredients),
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
                          "?????????", () => _setVisibility1(), _visibility1),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Visibility(
                          maintainState: true,
                          child: Wrap(
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.start,
                              children: [
                                IngredientButton(
                                    "?????????", "??????", seletecIngredients),
                                IngredientButton(
                                    "?????????", "??????", seletecIngredients),
                                IngredientButton(
                                    "?????????", "??????", seletecIngredients),
                                IngredientButton(
                                    "?????????", "??????", seletecIngredients),
                                IngredientButton(
                                    "?????????", "??????", seletecIngredients),
                                IngredientButton(
                                    "?????????", "??????", seletecIngredients),
                                IngredientButton(
                                    "?????????", "???", seletecIngredients),
                                IngredientButton(
                                    "?????????", "??????", seletecIngredients),
                                IngredientButton(
                                    "?????????", "???????????????", seletecIngredients),
                                IngredientButton(
                                    "?????????", "?????????", seletecIngredients),
                                IngredientButton(
                                    "?????????", "??????", seletecIngredients),
                                IngredientButton(
                                    "?????????", "??????", seletecIngredients),
                                IngredientButton(
                                    "?????????", "?????????", seletecIngredients),
                                IngredientButton(
                                    "?????????", "?????????", seletecIngredients),
                                IngredientButton(
                                    "?????????", "????????????", seletecIngredients),
                                IngredientButton(
                                    "?????????", "??????", seletecIngredients),
                                IngredientButton(
                                    "?????????", "????????????", seletecIngredients),
                                IngredientButton(
                                    "?????????", "????????????", seletecIngredients),
                                IngredientButton(
                                    "?????????", "????????????", seletecIngredients),
                                IngredientButton(
                                    "?????????", "??????", seletecIngredients),
                                IngredientButton(
                                    "?????????", "??????", seletecIngredients),
                                IngredientButton(
                                    "?????????", "?????????", seletecIngredients),
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
                          "?????????", () => _setVisibility2(), _visibility2),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Visibility(
                          maintainState: true,
                          child: Wrap(children: [
                            IngredientButton("?????????", "??????", seletecIngredients),
                            IngredientButton("?????????", "?????????", seletecIngredients),
                            IngredientButton("?????????", "?????????", seletecIngredients),
                            IngredientButton("?????????", "?????????", seletecIngredients),
                            IngredientButton("?????????", "???", seletecIngredients),
                            IngredientButton("?????????", "??????", seletecIngredients),
                            IngredientButton("?????????", "??????", seletecIngredients),
                            IngredientButton("?????????", "?????????", seletecIngredients),
                            IngredientButton("?????????", "??????", seletecIngredients),
                            IngredientButton("?????????", "??????", seletecIngredients),
                            IngredientButton("?????????", "??????", seletecIngredients),
                            IngredientButton("?????????", "??????", seletecIngredients),
                            IngredientButton("?????????", "??????", seletecIngredients),
                            IngredientButton("?????????", "??????", seletecIngredients),
                            IngredientButton("?????????", "?????????", seletecIngredients),
                            IngredientButton("?????????", "??????", seletecIngredients),
                            IngredientButton("?????????", "??????", seletecIngredients),
                            IngredientButton("?????????", "?????????", seletecIngredients),
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
                          "??????", () => _setVisibility3(), _visibility3),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Visibility(
                          maintainState: true,
                          child: Wrap(children: [
                            IngredientButton("??????", "??????", seletecIngredients),
                            IngredientButton("??????", "?????????", seletecIngredients),
                            IngredientButton("??????", "?????????", seletecIngredients),
                            IngredientButton("??????", "?????????", seletecIngredients),
                            IngredientButton("??????", "????????????", seletecIngredients),
                            IngredientButton("??????", "?????????", seletecIngredients),
                            IngredientButton("??????", "????????????", seletecIngredients),
                            IngredientButton("??????", "???", seletecIngredients),
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
                          "??????/?????????", () => _setVisibility4(), _visibility4),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Visibility(
                          maintainState: true,
                          child: Wrap(children: [
                            IngredientButton("???????????????", "??????", seletecIngredients),
                            IngredientButton(
                                "???????????????", "?????????", seletecIngredients),
                            IngredientButton(
                                "???????????????", "??????????????????", seletecIngredients),
                            IngredientButton(
                                "???????????????", "??????????????????", seletecIngredients),
                            IngredientButton(
                                "???????????????", "????????????", seletecIngredients),
                            IngredientButton("???????????????", "??????", seletecIngredients),
                            IngredientButton("???????????????", "??????", seletecIngredients),
                            IngredientButton("???????????????", "??????", seletecIngredients),
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
                          "???/?????????", () => _setVisibility5(), _visibility5),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Visibility(
                          maintainState: true,
                          child: Wrap(children: [
                            IngredientButton("????????????", "???", seletecIngredients),
                            IngredientButton("????????????", "??????", seletecIngredients),
                            IngredientButton("????????????", "???", seletecIngredients),
                            IngredientButton("????????????", "?????????", seletecIngredients),
                            IngredientButton("????????????", "??????", seletecIngredients),
                            IngredientButton("????????????", "?????????", seletecIngredients),
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
                          "??????", () => _setVisibility6(), _visibility6),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Visibility(
                          maintainState: true,
                          child: Wrap(children: [
                            IngredientButton("??????", "???", seletecIngredients),
                            IngredientButton("??????", "?????????", seletecIngredients),
                            IngredientButton("??????", "??????", seletecIngredients),
                            IngredientButton("??????", "??????", seletecIngredients),
                            IngredientButton("??????", "?????????", seletecIngredients),
                            IngredientButton("??????", "???", seletecIngredients),
                            IngredientButton("??????", "??????", seletecIngredients),
                            IngredientButton("??????", "????????????", seletecIngredients),
                            IngredientButton("??????", "?????????", seletecIngredients),
                            IngredientButton("??????", "??????", seletecIngredients),
                            IngredientButton("??????", "??????", seletecIngredients),
                            IngredientButton("??????", "????????????", seletecIngredients),
                            IngredientButton("??????", "??????", seletecIngredients),
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
                          "???", () => _setVisibility7(), _visibility7),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Visibility(
                          maintainState: true,
                          child: Wrap(children: [
                            IngredientButton("???", "????????????", seletecIngredients),
                            IngredientButton("???", "????????????", seletecIngredients),
                            IngredientButton("???", "?????????", seletecIngredients),
                            IngredientButton("???", "??????", seletecIngredients),
                            IngredientButton("???", "??????", seletecIngredients),
                            IngredientButton("???", "??????", seletecIngredients),
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
                          "???/???", () => _setVisibility8(), _visibility8),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Visibility(
                          maintainState: true,
                          child: Wrap(children: [
                            IngredientButton("??????", "??????", seletecIngredients),
                            IngredientButton("??????", "?????????", seletecIngredients),
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
                          "???/?????????", () => _setVisibility9(), _visibility9),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Visibility(
                          maintainState: true,
                          child: Wrap(children: [
                            IngredientButton("????????????", "?????????", seletecIngredients),
                            IngredientButton(
                                "????????????", "??????????????????", seletecIngredients),
                            IngredientButton("????????????", "?????????", seletecIngredients),
                            IngredientButton("????????????", "???", seletecIngredients),
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
                          "?????????/??????", () => _setVisibility10(), _visibility10),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Visibility(
                          maintainState: true,
                          child: Wrap(children: [
                            IngredientButton("???????????????", "??????", seletecIngredients),
                            IngredientButton(
                                "???????????????", "?????????", seletecIngredients),
                            IngredientButton(
                                "???????????????", "????????????", seletecIngredients),
                            IngredientButton(
                                "???????????????", "?????????", seletecIngredients),
                            IngredientButton("???????????????", "??????", seletecIngredients),
                            IngredientButton(
                                "???????????????", "????????????", seletecIngredients),
                            IngredientButton(
                                "???????????????", "????????????", seletecIngredients),
                            IngredientButton("???????????????", "??????", seletecIngredients),
                            IngredientButton("???????????????", "??????", seletecIngredients),
                            IngredientButton("???????????????", "??????", seletecIngredients),
                            IngredientButton(
                                "???????????????", "????????????", seletecIngredients),
                            IngredientButton("???????????????", "??????", seletecIngredients),
                            IngredientButton(
                                "???????????????", "????????????", seletecIngredients),
                            IngredientButton("???????????????", "??????", seletecIngredients),
                            IngredientButton(
                                "???????????????", "????????? ?????????", seletecIngredients),
                            IngredientButton(
                                "???????????????", "????????????", seletecIngredients),
                            IngredientButton(
                                "???????????????", "?????????", seletecIngredients),
                            IngredientButton("???????????????", "??????", seletecIngredients),
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
            padding: const EdgeInsets.only(bottom: 5),
            child: SizedBox(
              height: MediaQuery.of(context).size.width * 0.1,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, seletecIngredients);
                },
                style: ElevatedButton.styleFrom(
                    primary: Palette.orange, // Background color
                    onPrimary: Colors.white, // Text Color (Foreground color)
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                child: Text(
                  '????????????',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
