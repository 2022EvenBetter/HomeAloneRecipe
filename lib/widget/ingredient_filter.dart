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
    true,
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
    setState(() {
      for (var i = 0; i < _isV.length; i++) {
        _isV[i] = false;
      }
      _isV[index] = true;
      _isVisible1 = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
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
                              "?????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "???", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "???????????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "?????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "?????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "?????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "????????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "????????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "????????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "????????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "?????????", widget.addIng, widget.rmvIng),
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
                              "??????", "????????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "??????", "?????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "??????", "?????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "??????", "?????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "??????", "??????", widget.addIng, widget.rmvIng),
                        ],
                      )),
                  visible: _isV[0],
                ),
                Visibility(
                  maintainState: true,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          IngredientButtonForRecipeTab(
                              "?????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "?????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "?????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "?????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "???", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "?????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "?????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "?????????", "?????????", widget.addIng, widget.rmvIng),
                        ],
                      )),
                  visible: _isV[2],
                ),
                Visibility(
                  maintainState: true,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          IngredientButtonForRecipeTab(
                              "??????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "??????", "?????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "??????", "?????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "??????", "?????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "??????", "????????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "??????", "?????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "??????", "????????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "??????", "???", widget.addIng, widget.rmvIng),
                        ],
                      )),
                  visible: _isV[6],
                ),
                Visibility(
                  maintainState: true,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          IngredientButtonForRecipeTab(
                              "???????????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???????????????", "?????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???????????????", "??????????????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???????????????", "??????????????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???????????????", "????????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???????????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???????????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???????????????", "??????", widget.addIng, widget.rmvIng)
                        ],
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
                              "????????????", "???", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "????????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "????????????", "???", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "????????????", "?????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "????????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "????????????", "?????????", widget.addIng, widget.rmvIng),
                        ],
                      )),
                  visible: _isV[9],
                ),
                Visibility(
                  maintainState: true,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          IngredientButtonForRecipeTab(
                              "??????", "???", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "??????", "?????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "??????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "??????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "??????", "?????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "??????", "???", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "??????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "??????", "????????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "??????", "?????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "??????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "??????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "??????", "????????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "??????", "??????", widget.addIng, widget.rmvIng),
                        ],
                      )),
                  visible: _isV[5],
                ),
                Visibility(
                  maintainState: true,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          IngredientButtonForRecipeTab(
                              "???", "????????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???", "????????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???", "?????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???", "??????", widget.addIng, widget.rmvIng),
                        ],
                      )),
                  visible: _isV[7],
                ),
                Visibility(
                  maintainState: true,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          IngredientButtonForRecipeTab(
                              "??????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "??????", "?????????", widget.addIng, widget.rmvIng),
                        ],
                      )),
                  visible: _isV[8],
                ),
                Visibility(
                  maintainState: true,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          IngredientButtonForRecipeTab(
                              "????????????", "?????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "????????????", "??????????????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "????????????", "?????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "????????????", "???", widget.addIng, widget.rmvIng),
                        ],
                      )),
                  visible: _isV[3],
                ),
                Visibility(
                  maintainState: true,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          IngredientButtonForRecipeTab(
                              "???????????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???????????????", "?????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???????????????", "????????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???????????????", "?????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???????????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???????????????", "????????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???????????????", "????????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???????????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???????????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???????????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???????????????", "????????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???????????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???????????????", "????????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???????????????", "??????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???????????????", "????????? ?????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???????????????", "????????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???????????????", "?????????", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "???????????????", "??????", widget.addIng, widget.rmvIng),
                        ],
                      )),
                  visible: _isV[10],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
