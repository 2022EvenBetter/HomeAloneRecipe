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
                              "채소류", "가지", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "채소류", "고추", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "채소류", "김치", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "채소류", "대파", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "채소류", "당근", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "채소류", "마늘", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "채소류", "무", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "채소류", "배추", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "채소류", "양송이버섯", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "채소류", "양배추", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "채소류", "양파", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "채소류", "오이", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "채소류", "콩나물", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "채소류", "토마토", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "채소류", "파프리카", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "채소류", "호박", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "채소류", "팽이버섯", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "채소류", "표고버섯", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "채소류", "브로콜리", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "채소류", "비트", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "채소류", "상추", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "채소류", "샐러리", widget.addIng, widget.rmvIng),
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
                        children: [
                          IngredientButtonForRecipeTab(
                              "해산물", "갈치", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "해산물", "게맛살", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "해산물", "고등어", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "해산물", "골뱅이", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "해산물", "굴", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "해산물", "꽁치", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "해산물", "낙지", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "해산물", "다시마", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "해산물", "새우", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "해산물", "동태", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "해산물", "멸치", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "해산물", "문어", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "해산물", "미역", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "해산물", "조개", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "해산물", "오징어", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "해산물", "전복", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "해산물", "조기", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "해산물", "쭈꾸미", widget.addIng, widget.rmvIng),
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
                              "곡류", "감자", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "곡류", "고구마", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "곡류", "밀가루", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "곡류", "빵가루", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "곡류", "부침가루", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "곡류", "옥수수", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "곡류", "찹쌀가루", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "곡류", "쌀", widget.addIng, widget.rmvIng),
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
                              "가공유제품", "계란", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "가공유제품", "참치캔", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "가공유제품", "모짜렐라치즈", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "가공유제품", "슬라이스치즈", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "가공유제품", "옥수수콘", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "가공유제품", "버터", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "가공유제품", "우유", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "가공유제품", "어묵", widget.addIng, widget.rmvIng)
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
                              "콩견과류", "깨", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "콩견과류", "두부", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "콩견과류", "콩", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "콩견과류", "아몬드", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "콩견과류", "호두", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "콩견과류", "청국장", widget.addIng, widget.rmvIng),
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
                              "과일", "감", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "과일", "건포도", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "과일", "딸기", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "과일", "레몬", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "과일", "바나나", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "과일", "배", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "과일", "사과", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "과일", "아보카도", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "과일", "오렌지", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "과일", "체리", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "과일", "키위", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "과일", "파인애플", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "과일", "포도", widget.addIng, widget.rmvIng),
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
                              "면", "칼국수면", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "면", "파스타면", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "면", "우동면", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "면", "소면", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "면", "당면", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "면", "라면", widget.addIng, widget.rmvIng),
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
                              "빵떡", "식빵", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "빵떡", "떡국떡", widget.addIng, widget.rmvIng),
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
                              "햄소시지", "베이컨", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "햄소시지", "비엔나소시지", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "햄소시지", "소시지", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "햄소시지", "햄", widget.addIng, widget.rmvIng),
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
                              "조미료양념", "간장", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "조미료양념", "고추장", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "조미료양념", "고춧가루", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "조미료양념", "굴소스", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "조미료양념", "소금", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "조미료양념", "다진마늘", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "조미료양념", "멸치액젓", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "조미료양념", "설탕", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "조미료양념", "식초", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "조미료양념", "쌈장", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "조미료양념", "올리브유", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "조미료양념", "케첩", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "조미료양념", "마요네즈", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "조미료양념", "후추", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "조미료양념", "쇠고기 다시다", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "조미료양념", "카레가루", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "조미료양념", "참기름", widget.addIng, widget.rmvIng),
                          IngredientButtonForRecipeTab(
                              "조미료양념", "된장", widget.addIng, widget.rmvIng),
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
