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
import 'package:home_alone_recipe/screen/recipeDetail_screen.dart';
import 'ingredient_filter.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
String filterIngredient = "쌀";

class Api extends StatefulWidget {
  final apiResults;
  const Api(this.apiResults, {super.key});

  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {
  bool showWidget = false;

  FirebaseFirestore db = FirebaseFirestore.instance;

  bool isScrapped = false;

  void setIng(String ing) {
    setState(() {
      filterIngredient = ing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          IngredientFilter(setIng),
          Expanded(child: ListBuilder(filterIngredient)),
        ],
      ),
    );
  }
}

class ListBuilder extends StatefulWidget {
  final String filterIngredient;
  const ListBuilder(this.filterIngredient, {super.key});

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<String>> _getIngAPIbyIngName(String recipeName) async {
    final response = await http.get(Uri.parse(
        'http://211.237.50.150:7080/openapi/a0e05d197e3886ea191fa4f206b3b99dfc004411423b5e5187361ae7e6e651cd/xml/Grid_20150827000000000227_1/1/100?IRDNT_NM=${recipeName}'));
    List<String> ingResult = [];
    if (response.statusCode == 200) {
      final body = convert.utf8.decode(response.bodyBytes);

      // xml => json으로 변환
      final xml = Xml2Json()..parse(body);
      final json = xml.toParker();

      Map<String, dynamic> jsonResult = convert.json.decode(json);
      //print('응답');

      for (var i = 0;
          i < jsonResult['Grid_20150827000000000227_1']['row'].length;
          i++) {
        ingResult.add(
            jsonResult['Grid_20150827000000000227_1']['row'][i]['RECIPE_ID']);
      }
    } else {
      throw Exception('오류');
    }

    return ingResult;
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
      //print('응답');

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
      //print('응답');

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
    //print(data);

    _items = await data["recipe"];
    print("read json");

    return _items;
  }

  Future<List<Recipe>> _MakeRecipeArray(
      List<dynamic> recipeInfo, List<dynamic> recipeMake) async {
    List<Recipe> _recipe = [];

    for (var i = 0; i < recipeInfo.length; i++) {
      //print("레시피설명 불러오는중");

      List<String> _recipeIng = await _getIngAPI(recipeInfo[i]);
      List<String> _recipeMake = await _getRecipeAPI(recipeInfo[i]);

      _recipe.add(Recipe(
          recipeMake[i]['레시피 이름'],
          recipeMake[i]['대표이미지 URL'],
          int.parse(recipeInfo[i]),
          recipeMake[i]['간략(요약) 소개'],
          _recipeIng,
          _recipeMake));
    }

    return await _recipe;
  }

  Future<List<Recipe>> _getFiteredRecipe() async {
    print(widget.filterIngredient);
    if (widget.filterIngredient != "") {
      final List<String> filteredRecipecode =
          await _getIngAPIbyIngName(widget.filterIngredient);

      final List<dynamic> filteredRecipeArray = [];

      List<dynamic> allRecipes = await readJson();

      for (var i = 0; i < allRecipes.length; i++) {
        for (var j = 0; j < filteredRecipecode.length; j++) {
          if (allRecipes[i]["레시피 코드"] == int.parse(filteredRecipecode[j])) {
            filteredRecipeArray.add(allRecipes[i]);
            print("filtered");
          }
        }
      }
      //print(filteredRecipeArray.length);
      //print(filteredRecipecode);
      return await _MakeRecipeArray(filteredRecipecode, filteredRecipeArray);
    } else {
      List<Recipe> emptyArr = [];
      return emptyArr;
    }
  }

  bool isScrap = true;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getFiteredRecipe(),
        builder: ((BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
          List<Recipe> snapRecipe = [];

          //print("111111111111111111111111111111111111");
          //print(snapshot);
          if (snapshot.hasData) {
            //print("222222222222222222222222222222222222");
            //print(snapshot.data![0].recipeName);
            snapshot.data!.forEach((element) {
              Recipe r = element as Recipe;
              snapRecipe.add(r);
              print("Recipe Snap For");
            });
          }
          //print(snapshot.connectionState);

          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Text('총${snapRecipe.length}개의 레시피가 나왔어요!'),
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
                                                      // icon: isScrap
                                                      //     ? Icon(Icons.favorite)
                                                      //     : Icon(Icons
                                                      //         .favorite_outline),
                                                      icon:
                                                          Icon(Icons.favorite),
                                                      focusColor: Colors.amber,
                                                      isSelected: false,
                                                      selectedIcon: Icon(Icons
                                                          .favorite_border),
                                                      onPressed: () {
                                                        // setState(() {
                                                        //   isScrap = !isScrap;
                                                        // });
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(10, 0, 10, 0),
                                                    child: Text('55'),
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
                              ],
                            ));
                      }),
                )
              ],
            );
          }
          return const Text('hi');
        }));
  }
}
