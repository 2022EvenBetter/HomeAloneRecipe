import 'dart:convert' as convert;
import 'dart:developer';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xml/xml.dart';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;
import 'package:home_alone_recipe/widget/getRecipe.dart';
import 'package:home_alone_recipe/models/recipe.dart';

class Api extends StatefulWidget {
  final apiResults;
  const Api(this.apiResults, {super.key});

  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {
  bool showWidget = false;

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List> _getRecipe(String ingredient) async {
    var pureRecipeArr = [];

    return pureRecipeArr;
  }

  void _refresh() {
    widget.apiResults.clear();
    print(widget.apiResults);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    _getRecipe("안심");
                  },
                  child: Text('사용불가')),
              ElevatedButton(onPressed: () {}, child: Text('refresh')),
            ],
          ),
          Expanded(child: ListBuilder()),
          //Test(),
        ],
      ),
    );
  }
}

class ListBuilder extends StatefulWidget {
  const ListBuilder({super.key});

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  // Future<QuerySnapshot<Map<String, dynamic>>> _FetchRecipeIngredients(
  //     int recipeCode) async {
  //   print("고등어배열들");
  //   print(recipeCode);
  //   return db
  //       .collection("recipeIngredients")
  //       .where("레시피 코드", isEqualTo: recipeCode)
  //       .get();
  // }
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
      print('응답');

      for (var i = 0;
          i < jsonResult['Grid_20150827000000000227_1']['row'].length;
          i++) {
        ingResult.add(
            jsonResult['Grid_20150827000000000227_1']['row'][i]['RECIPE_ID']);
      }

      print(ingResult);
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
      print('응답');

      for (var i = 0;
          i < jsonResult['Grid_20150827000000000227_1']['row'].length;
          i++) {
        ingResult.add(
            jsonResult['Grid_20150827000000000227_1']['row'][i]['IRDNT_NM']);
      }

      print(ingResult);
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
      print('응답');

      for (var i = 0;
          i < jsonResult['Grid_20150827000000000228_1']['row'].length;
          i++) {
        ingResult.add(
            jsonResult['Grid_20150827000000000228_1']['row'][i]['COOKING_DC']);
      }

      print(ingResult);
    } else {
      throw Exception('오류');
    }

    return ingResult;
  }

  Future<List<dynamic>> readJson() async {
    List<dynamic> _items = [];
    final String response =
        await rootBundle.loadString('lib/assets/recipeInfo.json');
    print(response);
    final data = await convert.json.decode(response);
    //print(data);

    _items = await data["recipe"];
    print("read json");
    print(_items.length);

    return _items;
  }

  Future<Map<String, dynamic>> _FetchRecipeInfo(int recipeCode) async {
    var a = await db
        .collection("recipe")
        .where("레시피 코드", isEqualTo: recipeCode)
        .get();
    print("info)");
    print(a.docs.length);
    return a.docs[0].data();
  }

  Future<List<Recipe>> _MakeRecipeArray(
      List<dynamic> recipeInfo, List<dynamic> recipeMake) async {
    List<Recipe> _recipe = [];
    for (var i = 0; i < recipeInfo.length; i++) {
      print("레시피설명 불러오는중");
      //print(recipeInfo.docs[0].data()['재료명']);
      List<String> _recipeIng = await _getIngAPI(recipeInfo[i]);
      List<String> _recipeMake = await _getRecipeAPI(recipeInfo[i]);
      print("recipeMake arr");
      print(recipeMake);

      _recipe.add(Recipe(
          recipeMake[i]['레시피 이름'],
          recipeMake[i]['대표이미지 URL'],
          int.parse(recipeInfo[i]),
          recipeMake[i]['간략(요약) 소개'],
          _recipeIng,
          _recipeMake));
    }
    print('recipe : ');
    print(_recipe);
    return await _recipe;
  }

  Future<List<Recipe>> _getFiteredRecipe() async {
    final List<String> filteredRecipecode = await _getIngAPIbyIngName("쪽파");
    //고등어를 가지고 있는 데이터를 가져옴
    print("filtered code");
    print(filteredRecipecode);

    final List<dynamic> filteredRecipeArray = [];

    List<dynamic> allRecipes = await readJson();
    //print("allrecipe");
    print(allRecipes);
    for (var i = 0; i < allRecipes.length; i++) {
      //print('recipeNameFor${filteredRecipecode[i]}');
      //print(allRecipes[i]);

      for (var j = 0; j < filteredRecipecode.length; j++) {
        // print(allRecipes[i]["레시피 코드"].runtimeType);
        // print(allRecipes[i]["레시피 코드"]);
        // print(filteredRecipecode[j].runtimeType);
        // print(filteredRecipecode[j]);
        if (allRecipes[i]["레시피 코드"] == int.parse(filteredRecipecode[j])) {
          filteredRecipeArray.add(allRecipes[i]);
          print("filtered");
        }
      }
      //print(filteredRecipeArray);
      //고등어를 가지고 있는 레시피의 코드를 추출하여 레시피 이름을 포함한 레시피 데이터를 가져옴
    }

    return await _MakeRecipeArray(filteredRecipecode, filteredRecipeArray);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getFiteredRecipe(),
        builder: ((BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
          List<Recipe> snapRecipe = [];

          print("111111111111111111111111111111111111");
          print(snapshot);
          if (snapshot.hasData) {
            print("222222222222222222222222222222222222");
            print(snapshot.data![0].recipeName);
            snapshot.data!.forEach((element) {
              Recipe r = element as Recipe;
              snapRecipe.add(r);
              print("Recipe Snap For");
            });
          }
          print(snapshot.connectionState);

          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: snapRecipe.length,
                itemBuilder: (BuildContext context, int idx) {
                  return ListTile(
                    title: Text(
                        '${snapRecipe[idx].recipeName}${snapRecipe[idx].recipeCode}'),
                    subtitle: Text(snapRecipe[idx].description),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RecipeDetailPage(snapRecipe[idx])),
                      );
                    },
                  );
                });
          }

          return const Text('hi');
        }));
  }
}

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;
  const RecipeDetailPage(this.recipe, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: 200.0,
                child: Image.network(
                  recipe.imageURL,
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
                          recipe.recipeName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.favorite,
                        ),
                      ),
                      Text('55'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '이미 스크랩 하셨습니다.',
                        ),
                      ),
                    ],
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
                          for (var i = 0; i < recipe.ingredients.length; i++)
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                recipe.ingredients[i],
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
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
                        children: [
                          for (var i = 0; i < recipe.recipe.length; i++)
                            Text(
                              '${i + 1} : ${recipe.recipe[i]}',
                              style: TextStyle(fontSize: 15.0),
                              textAlign: TextAlign.left,
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

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  Future<Map<String, dynamic>> getMake() async {
    dd();
    var a = await db.collection("recipe").get();
    print("test");
    //print(a.docs);
    return a.docs[0].data();
  }

  void dd() {
    print("hello");
    db.collection("recipeMake").get().then((value) {
      value.docs.forEach((element) {
        print(element.data());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getMake(),
        builder: ((BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot);
          return Text('1');
        }));
  }
}
