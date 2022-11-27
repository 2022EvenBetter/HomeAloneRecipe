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
import 'package:home_alone_recipe/provider/userProvider.dart';
import 'package:provider/provider.dart';

class RecipeDetailPage extends StatefulWidget {
  final Recipe recipe;
  const RecipeDetailPage(this.recipe, {super.key});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  late UserProvider _userProvider;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<bool> hasData(int recipeCode) async {
    var data = await db
        .collection("recipeScrap")
        .where("recipeCode", isEqualTo: recipeCode)
        .get();
    return data.docs.isEmpty;
  }

  Future initRecipeScrap(int recipeCodeNum) async {
    var isEmpty = await hasData(recipeCodeNum);
    if (isEmpty) {
      db.collection("recipeScrap").doc().set(
          {"recipeCode": recipeCodeNum, "scrapNum": 0},
          SetOptions(merge: true));
      print("init data");
    } else {
      print("already exist");
    }
  }

  Future<int> getScrapNum(int recipeCodeNum) async {
    var data =
        await db.collection("recipeScrap").doc(recipeCodeNum.toString()).get();

    return data.data()!["scrapNum"];
  }

  Future setScrapNum(int recipeCodeNum, int recipeScrapNum) async {
    //var updateData = db.collection("recipeScrap").where("recipeCode", isEqualTo: recipeCodeNum).get();

    //updateData.update(data)
    db
        .collection("recipeScrap")
        .doc(recipeCodeNum.toString())
        .set({"scrapNum": recipeScrapNum}, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    bool isScrap = false;
    int isClicked = 1;
    bool isClicked2 = false;
    bool changeMode = false;
    //int tmpScrap = await getScrapNum(widget.recipe.recipeCode);
    int tmpScrapNum = 0;
    for (var i = 0; i < _userProvider.recipes.length; i++) {
      if (_userProvider.recipes.contains(widget.recipe.recipeCode)) {
        isScrap = true;
        isClicked = -1;
        changeMode = true;
      }
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '상세보기',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          centerTitle: true,
          elevation: 3.0,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: 200.0,
                child: Image.network(
                  widget.recipe.imageURL,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.recipe.recipeName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              icon: isScrap
                                  ? Icon(Icons.favorite)
                                  : Icon(Icons.favorite_outline),
                              focusColor: Colors.amber,
                              isSelected: false,
                              selectedIcon: Icon(Icons.favorite_border),
                              onPressed: () {
                                setState(() {
                                  isClicked2 = !isClicked2;
                                  print(isClicked2);
                                  print(changeMode);
                                });
                                setState(() async {
                                  isScrap = !isScrap;

                                  tmpScrapNum = await getScrapNum(
                                      widget.recipe.recipeCode);
                                  if (isScrap) {
                                    _userProvider
                                        .scrapRecipe(widget.recipe.recipeCode);
                                    tmpScrapNum += 1;
                                    setScrapNum(
                                        widget.recipe.recipeCode, tmpScrapNum);
                                    await FirebaseFirestore.instance
                                        .collection("User")
                                        .doc(_userProvider.uid)
                                        .set({
                                      "MyRecipes": _userProvider.recipes
                                    }, SetOptions(merge: true));
                                  } else {
                                    _userProvider
                                        .removeRecipe(widget.recipe.recipeCode);
                                    tmpScrapNum -= 1;
                                    setScrapNum(
                                        widget.recipe.recipeCode, tmpScrapNum);
                                    await FirebaseFirestore.instance
                                        .collection("User")
                                        .doc(_userProvider.uid)
                                        .set({
                                      "MyRecipes": _userProvider.recipes
                                    }, SetOptions(merge: true));
                                  }
                                  print("유저 좋아요 레시피");
                                  print(_userProvider.recipes);
                                  print(tmpScrapNum);
                                  //print(tmpScrapNum);
                                });
                              },
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: null),
                          FutureBuilder(
                              future: getScrapNum(widget.recipe.recipeCode),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return Text(snapshot.data.toString());
                                }
                                return Text("123");
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  width: 500,
                  child: Divider(color: Colors.grey, thickness: 1.0)),
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '재료',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Wrap(
                        direction: Axis.horizontal, // 나열 방향
                        alignment: WrapAlignment.start,
                        children: [
                          for (var i = 0;
                              i < widget.recipe.ingredients.length;
                              i++)
                            _userProvider.ingredients
                                    .contains(widget.recipe.ingredients[i])
                                ? Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      widget.recipe.ingredients[i],
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      widget.recipe.ingredients[i],
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                  )
                        ]),
                  )
                ],
              ),
              Container(
                  width: 500,
                  child: Divider(color: Colors.grey, thickness: 1.0)),
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '레시피',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        verticalDirection: VerticalDirection.down,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var i = 0; i < widget.recipe.recipe.length; i++)
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                '${i + 1} : ${widget.recipe.recipe[i]}',
                                style: TextStyle(fontSize: 15.0),
                                textAlign: TextAlign.left,
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
