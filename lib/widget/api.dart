import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xml/xml.dart';
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

  Future<QuerySnapshot<Map<String, dynamic>>> _FetchRecipeIngredients(
      int recipeCode) async {
    print("고등어배열들");
    print(recipeCode);
    return db
        .collection("recipeIngredients")
        .where("레시피 코드", isEqualTo: 1)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> _FetchRecipe(
      String ingredient) async {
    print("고등어");
    return db
        .collection("recipeIngredients")
        .where("재료명", isEqualTo: ingredient)
        .get();
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

  Future<List<dynamic>> _FetchRecipeMake(int recipeCode) async {
    var a = await db
        .collection("recipeMake")
        .where("레시피 코드", isEqualTo: recipeCode)
        .get();
    print("레시피 설명 넣는중");
    print(recipeCode);
    print(a.docs);
    print(a.docs.length);

    return a.docs;
  }

  Future<List<Recipe>> _MakeRecipeArray(
      QuerySnapshot<Map<String, dynamic>> recipeInfo,
      List<Map<String, dynamic>> recipeMake) async {
    List<Recipe> _recipe = [];
    for (var i = 0; i < recipeInfo.docs.length; i++) {
      print("레시피설명 불러오는중");
      //print(recipeInfo.docs[0].data()['재료명']);
      var _recipeIngSnapshot =
          await _FetchRecipeIngredients(recipeInfo.docs[i]['레시피 코드']);
      List<String> _recipeIng = [];
      print(_recipeIngSnapshot.docs);
      for (var j = 0; j < _recipeIngSnapshot.docs.length; j++) {
        print(_recipeIngSnapshot.docs[j].data()['재료명']);
        _recipeIng.add(_recipeIngSnapshot.docs[j].data()['재료명']);
      }
      _recipe.add(Recipe(
          recipeMake[i]['레시피 이름'],
          recipeMake[i]['대표이미지 URL'],
          recipeInfo.docs[i].data()['레시피 코드'],
          recipeMake[i]['간략(요약) 소개'],
          _recipeIng));
    }
    print('recipe : ');
    print(_recipe);
    return await _recipe;
  }

  Future<List<Recipe>> _getFiteredRecipe() async {
    final QuerySnapshot<Map<String, dynamic>> recipeIngredient =
        await _FetchRecipe("안심");
    //고등어를 가지고 있는 데이터를 가져옴
    print(recipeIngredient.docs[0].data()['레시피 코드']);
    final List<Map<String, dynamic>> recipeName = [];
    final List<Recipe> filteredRecipeArray = [];
    print(recipeIngredient.docs.length);

    print(recipeIngredient.docs[0].data());
    for (var i = 0; i < recipeIngredient.docs.length; i++) {
      print('recipeNameFor${recipeIngredient.docs[i]['레시피 코드']}');
      recipeName
          .add(await _FetchRecipeInfo(recipeIngredient.docs[i]['레시피 코드']));

      print(recipeName[i]);
      //고등어를 가지고 있는 레시피의 코드를 추출하여 레시피 이름을 포함한 레시피 데이터를 가져옴
    }

    return await _MakeRecipeArray(recipeIngredient, recipeName);
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
            });
          }

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
