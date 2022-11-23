import 'dart:convert' as convert;
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_alone_recipe/widget/ingredient_button.dart';
import 'package:xml/xml.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;
import 'package:home_alone_recipe/widget/getRecipe.dart';
import 'package:home_alone_recipe/models/recipe.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'category_dropdown.dart';

class IngredientFilter extends StatefulWidget {
  const IngredientFilter(this.addIng, this.rmvIng, {super.key});
  final Function addIng;
  final Function rmvIng;
  @override
  State<IngredientFilter> createState() => _IngredientFilterState();
}

class _IngredientFilterState extends State<IngredientFilter> {
  List<bool> _isV = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  bool _isVisible1 = false;
  bool _isVisible2 = true;
  void setVisible(int index) {
    print(111);
    print(index);
    setState(() {
      for (var i = 0; i < _isV.length; i++) {
        print('for');
        _isV[i] = false;
      }
      _isV[index] = true;
      _isVisible1 = true;
    });

    print(_isV[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Column(
        children: [
          CategoryDropdown(setVisible),
          Expanded(
            child: Column(
              children: [
                Visibility(
                  maintainState: true,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          IngredientButtonForRecipeTab(
                              "채소류", "버섯", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "채소류", "고추", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "채소류", "배추", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "채소류", "양배추", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "채소류", "마늘", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "채소류", "바질", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "채소류", "브로콜리", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "채소류", "당근", widget.addIng, widget.rmvIng),
                        ],
                      )),
                  visible: _isV[1],
                ),
                Visibility(
                  maintainState: true,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          IngredientButtonForRecipeTab(
                              "육류", "돼지고기", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "육류", "소고기", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "육류", "닭고기", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "육류", "다짐육", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "육류", "곱창", widget.addIng, widget.rmvIng),
                        ],
                      )),
                  visible: _isV[0],
                ),
                Visibility(
                  maintainState: true,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [],
                      )),
                  visible: _isV[2],
                ),
                Visibility(
                  maintainState: true,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [],
                      )),
                  visible: _isV[3],
                ),
                Visibility(
                  maintainState: true,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [],
                      )),
                  visible: _isV[4],
                ),
                Visibility(
                  maintainState: true,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          IngredientButtonForRecipeTab(
                              "과일", "딸기", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "과일", "바나나", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "과일", "배", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "과일", "사과", widget.addIng, widget.rmvIng),
                        ],
                      )),
                  visible: _isV[5],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
