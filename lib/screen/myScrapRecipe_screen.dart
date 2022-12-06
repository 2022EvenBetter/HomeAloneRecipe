import 'dart:convert' as convert;

import 'package:home_alone_recipe/constants/ingredientCategory.dart' as ingr;
import 'dart:ffi' as ffi;
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_alone_recipe/provider/userProvider.dart';
import 'package:home_alone_recipe/widget/ingredient_button.dart';
import 'package:xml/xml.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;
import 'package:home_alone_recipe/widget/getRecipe.dart';
import 'package:home_alone_recipe/models/recipe.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:home_alone_recipe/screen/recipeDetail_screen.dart';

import 'package:provider/provider.dart';
import 'package:home_alone_recipe/config/palette.dart';
import 'package:home_alone_recipe/provider/userProvider.dart';
import 'package:home_alone_recipe/widget/api.dart';
import 'package:provider/provider.dart';

class MyScrapRecipeScreen extends StatefulWidget {
  const MyScrapRecipeScreen({super.key});

  @override
  State<MyScrapRecipeScreen> createState() => _MyScrapRecipeScreenState();
}

class _MyScrapRecipeScreenState extends State<MyScrapRecipeScreen> {
  late UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '레시피',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 3.0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[Expanded(child: ListBuilder(_userProvider.recipes))],
      ),
    );
  }
}

class ListBuilder extends StatefulWidget {
  final List<int> filterIngredient;
  const ListBuilder(this.filterIngredient, {super.key});

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  late UserProvider _userProvider;
  Map<String, dynamic> ing = ingr.ing;

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<bool> hasData(int recipeCode) async {
    var data =
        await db.collection("recipeScrap").doc(recipeCode.toString()).get();
    return data.exists;
  }

  Future<int> getScrapNum(int recipeCodeNum) async {
    var data =
        await db.collection("recipeScrap").doc(recipeCodeNum.toString()).get();

    return data.data()!["scrapNum"];
  }

  Future<List<String>> _getIngAPI(String recipeCode) async {
    final response = await http.get(Uri.parse(
        'http://211.237.50.150:7080/openapi/a0e05d197e3886ea191fa4f206b3b99dfc004411423b5e5187361ae7e6e651cd/xml/Grid_20150827000000000227_1/1/100?RECIPE_ID=${recipeCode}'));
    List<String> ingResult = [];
    if (response.statusCode == 200) {
      final body = convert.utf8.decode(response.bodyBytes);

      // xml => json으로 변환
      final xml = Xml2Json()..parse(body);
      final json = xml.toParker();

      Map<String, dynamic> jsonResult = convert.json.decode(json);

      for (var i = 0;
          i < jsonResult['Grid_20150827000000000227_1']['row'].length;
          i++) {
        ingResult.add(
            jsonResult['Grid_20150827000000000227_1']['row'][i]['IRDNT_NM']);
      }
    } else {
      throw Exception('오류');
    }

    return ingResult;
  }

  Future<List<String>> _getRecipeAPI(String recipeCode) async {
    final response = await http.get(Uri.parse(
        'http://211.237.50.150:7080/openapi/a0e05d197e3886ea191fa4f206b3b99dfc004411423b5e5187361ae7e6e651cd/xml/Grid_20150827000000000228_1/1/10?RECIPE_ID=${recipeCode}'));
    List<String> ingResult = [];

    if (response.statusCode == 200) {
      final body = convert.utf8.decode(response.bodyBytes);

      // xml => json으로 변환
      final xml = Xml2Json()..parse(body);
      final json = xml.toParker();

      Map<String, dynamic> jsonResult = convert.json.decode(json);

      for (var i = 0;
          i < jsonResult['Grid_20150827000000000228_1']['row'].length;
          i++) {
        ingResult.add(
            jsonResult['Grid_20150827000000000228_1']['row'][i]['COOKING_DC']);
      }
    } else {
      throw Exception('오류');
    }

    return ingResult;
  }

  Future<List<dynamic>> readJson() async {
    List<dynamic> _items = [];
    final String response =
        await rootBundle.loadString('lib/assets/recipeInfo.json');

    final data = await convert.json.decode(response);

    _items = await data["recipe"];
    print("read json");

    return _items;
  }

  Future<List<Recipe>> _MakeRecipeArray(
      List<dynamic> recipeInfo, List<dynamic> recipeMake) async {
    List<Recipe> _recipe = [];

    for (var i = 0; i < recipeMake.length; i++) {
      //print("레시피설명 불러오는중");

      int scrapNum = await getScrapNum(recipeInfo[i]);
      List<String> _recipeIng = await _getIngAPI(recipeInfo[i].toString());
      List<String> _recipeMake = await _getRecipeAPI(recipeInfo[i].toString());

      _recipe.add(Recipe(
          recipeMake[i]['레시피 이름'],
          recipeMake[i]['대표이미지 URL'],
          recipeInfo[i],
          recipeMake[i]['간략(요약) 소개'],
          _recipeIng,
          _recipeMake,
          scrapNum));
    }

    return await _recipe;
  }

  Future<List<Recipe>> _getFiteredRecipe(List<int> code) async {
    if (widget.filterIngredient != "") {
      final List<dynamic> filteredRecipeArray = [];

      List<dynamic> allRecipes = await readJson();
      for (var i = allRecipes.length - 1; i >= 0; i--) {
        for (var j = code.length - 1; j >= 0; j--) {
          if (allRecipes[i]["레시피 코드"] == code[j]) {
            filteredRecipeArray.add(allRecipes[i]);
          }
        }
      }

      return await _MakeRecipeArray(code, filteredRecipeArray);
    } else {
      List<Recipe> emptyArr = [];
      return emptyArr;
    }
  }

  bool isScrap = true;
  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    return FutureBuilder(
        future: _getFiteredRecipe(widget.filterIngredient),
        builder: ((BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
          List<Recipe> snapRecipe = [];

          print(snapshot);
          if (snapshot.hasData) {
            snapshot.data!.forEach((element) {
              Recipe r = element as Recipe;
              snapRecipe.add(r);
            });
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                (snapRecipe.length >= 1)
                    ? Text('총${snapRecipe.length}개의 스크랩한 레시피입니다!')
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('스크랩한 레시피가 없습니다!',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                        ],
                      ),
                Expanded(
                  child: ListView.builder(
                      itemCount: snapRecipe.length,
                      itemBuilder: (BuildContext context, int idx) {
                        return Container(
                            margin: EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 110.0,
                                      height: 110.0,
                                      child: Image.network(
                                        snapRecipe[idx].imageURL,
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                    ),
                                    Container(
                                      height: 110,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 210,
                                            child: Column(
                                              children: [
                                                Text(
                                                  '${snapRecipe[idx].recipeName}',
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Container(
                                                    width: 180,
                                                    child: Text(
                                                      snapRecipe[idx]
                                                          .description,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 30,
                                                    child: IconButton(
                                                      padding: EdgeInsets.zero,
                                                      constraints:
                                                          BoxConstraints(),
                                                      icon: _userProvider
                                                              .recipes
                                                              .contains(
                                                                  snapRecipe[
                                                                          idx]
                                                                      .recipeCode)
                                                          ? Icon(
                                                              Icons.favorite,
                                                              color:
                                                                  Colors.yellow,
                                                            )
                                                          : Icon(
                                                              Icons
                                                                  .favorite_border,
                                                              color: Colors
                                                                  .yellow),
                                                      focusColor: Colors.amber,
                                                      isSelected: false,
                                                      selectedIcon: Icon(Icons
                                                          .favorite_border),
                                                      onPressed: () {},
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(10, 0, 10, 0),
                                                    child: Text(
                                                        '${snapRecipe[idx].scrapped}'),
                                                  ),
                                                  ConstrainedBox(
                                                    constraints:
                                                        BoxConstraints.tightFor(
                                                            height: 25),
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    RecipeDetailPage(
                                                                        snapRecipe[
                                                                            idx])));
                                                      },
                                                      child: Text('자세히 보기 >'),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          3,
                                                                          3,
                                                                          3,
                                                                          3),
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              shadowColor: Colors
                                                                  .transparent),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                              ],
                            ));
                      }),
                )
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        }));
  }
}
