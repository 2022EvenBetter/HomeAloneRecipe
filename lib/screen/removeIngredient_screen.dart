import 'dart:convert' as convert;
import 'package:home_alone_recipe/config/palette.dart';
import 'package:home_alone_recipe/constants/ingredientCategory.dart' as ing;
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_alone_recipe/widget/ingredient_button.dart';
import 'package:home_alone_recipe/widget/userIngredient.dart';
import 'package:xml/xml.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;
import 'package:home_alone_recipe/widget/getRecipe.dart';
import 'package:home_alone_recipe/models/recipe.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:home_alone_recipe/provider/userProvider.dart';
import 'package:provider/provider.dart';

class removeIngredient extends StatefulWidget {
  const removeIngredient({super.key});

  @override
  State<removeIngredient> createState() => _removeIngredientState();
}

class _removeIngredientState extends State<removeIngredient> {
  List<String> selectedIngredient = [];

  void setRemoveIngredient(String name) {
    setState(() {
      selectedIngredient.add(name);
    });
  }

  void cancelRemoveIngredient(String name) {
    setState(() {
      selectedIngredient.remove(name);
    });
  }

  void showPopup(context, List<String> removeIng) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        for (var i = 0; i < removeIng.length; i++)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Text("${removeIng[i]}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                textAlign: TextAlign.center),
                          ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Text("을 삭제하시겠어요?",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 110,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.pop(context, selectedIngredient);
                              },
                              icon: const Icon(Icons.circle_outlined),
                              label: const Text('네'),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff686EFF),
                                onPrimary: Colors.white, // Background color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 110,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.close),
                              label: const Text('아니요'),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff686EFF),
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ), // Background color
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            '재료 삭제하기',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          centerTitle: true,
          elevation: 3.0,
          backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Text('식재료',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Container(
              padding: EdgeInsets.only(top: 30),
              child: userIngredient(selectedIngredient, setRemoveIngredient,
                  cancelRemoveIngredient),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Palette.blue),
                      onPressed: () async {
                        selectedIngredient = [];
                        Navigator.pop(context, selectedIngredient);
                      },
                      child: Text(
                        '취소하기',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                      onPressed: () async {
                        if (!selectedIngredient.isEmpty) {
                          showPopup(context, selectedIngredient);
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text(
                                    '삭제할 재료가 없습니다.',
                                    textAlign: TextAlign.center,
                                  ),
                                  actions: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          '확인',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Palette.blue,
                                          onPrimary:
                                              Colors.white, // Background color
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              });
                        }
                        //Navigator.pop(context, selectedIngredient);
                      },
                      child: Text('삭제하기')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
