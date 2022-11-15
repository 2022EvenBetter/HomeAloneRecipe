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

  //XmlDocument? xmlData;
//   void _callAPI() async {
//     final url = Uri.parse(
//         'http://211.237.50.150:7080/openapi/a0e05d197e3886ea191fa4f206b3b99dfc004411423b5e5187361ae7e6e651cd/xml/Grid_20150827000000000227_1/1/100?IRDNT_NM=쌀');
// // 재료검색 (쌀) => 쌀에 관련된 레시피 코드 리스트 => 리스트를 순회하여 api 호출
//     final response = await http.get(url);
//     print('Response Status : ${response.statusCode}');
//     xmlData = XmlDocument.parse(response.body);
//     final wantData = xmlData!
//         .findAllElements('RECIPE_ID')
//         .map((node) => node.text)
//         .forEach((node) {
//       widget.apiResults.add(node);
//     });
//     print(widget.apiResults);
//   }
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List> _getRecipe(String ingredient) async {
    var pureRecipeArr = [];
    //var loadedRecipe = [];
    // var recipe =
    //     db.collection("recipeIngredients").where("재료명", isEqualTo: ingredient);
    // recipe.get().then((docSnaps) => {
    //       docSnaps.docs.forEach((element) {
    //         Map<String, dynamic> data = element.data() as Map<String, dynamic>;
    //         db
    //             .collection("recipe")
    //             .where("레시피 코드", isEqualTo: data["레시피 코드"])
    //             .get()
    //             .then((recipeSnap) => {
    //                   recipeSnap.docs.forEach((recipeData) {
    //                     Map<String, dynamic> recipeD =
    //                         recipeData.data() as Map<String, dynamic>;
    //                     print(recipeD["레시피 이름"]);
    //                     pureRecipeArr.add(Recipe(
    //                         recipeD["레시피 이름"],
    //                         recipeD["대표이미지 URL"],
    //                         recipeD["레시피 코드"],
    //                         recipeD["간략(요약) 소개"]));
    //                   })
    //                 });
    //       })
    //     });

    //recipeArr = pureRecipeArr;

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
                  child: Text('Call API')),
              ElevatedButton(
                  onPressed: () {
                    _refresh();
                  },
                  child: Text('refresh')),
            ],
          ),
          Expanded(child: ListBuilder()),
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

  Future<List> getMake(Map<String, dynamic> data, List<dynamic> ingArr) async {
    db
        .collection("recipeMake")
        .where("레시피 코드", isEqualTo: data["레시피 코드"])
        .get()
        .then((ingSnap) => {
              ingSnap.docs.forEach((element) {
                Map<String, dynamic> ing =
                    element.data() as Map<String, dynamic>;
                //print('${ing['레시피 코드']}${ing['요리설명']}');
                ingArr.add(ing["요리설명"]);
                //print(ingArr);
              })
            });
    return await Future.delayed(Duration(seconds: 1), () {
      return ingArr;
    });
  }

  Future<List> _getRecipe(var ingredient) async {
    var pureRecipeArr = [];
    var loadedRecipe = [];
    var recipe =
        db.collection("recipeIngredients").where("재료명", isEqualTo: ingredient);

    recipe.get().then((docSnaps) => {
          docSnaps.docs.forEach((element) {
            Map<String, dynamic> data = element.data() as Map<String, dynamic>;
            db
                .collection("recipe")
                .where("레시피 코드", isEqualTo: data["레시피 코드"])
                .get()
                .then((recipeSnap) => {
                      recipeSnap.docs.forEach((recipeData) {
                        Map<String, dynamic> recipeD =
                            recipeData.data() as Map<String, dynamic>;
                        //print(recipeD["레시피 이름"]);
                        List<String> ingArr = [];
                        db
                            .collection("recipeMake")
                            .where("레시피 코드", isEqualTo: data["레시피 코드"])
                            .get()
                            .then((ingSnap) => {
                                  ingSnap.docs.forEach((element) {
                                    Map<String, dynamic> ing =
                                        element.data() as Map<String, dynamic>;
                                    print('${ing['레시피 코드']}${ing['요리설명']}');
                                    ingArr.add(ing["요리설명"]);
                                    print(ingArr);
                                  }),
                                  pureRecipeArr.add(Recipe(
                                      recipeD["레시피 이름"],
                                      recipeD["대표이미지 URL"],
                                      recipeD["레시피 코드"],
                                      recipeD["간략(요약) 소개"],
                                      ingArr))
                                });
                        //ingArr = getMake(data, ingArr);

                        //print(pureRecipeArr.length);
                      })
                    });
          })
        });

    return await Future.delayed(Duration(seconds: 3), () {
      //print(pureRecipeArr);
      return pureRecipeArr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getRecipe("고등어"),
        builder: ((BuildContext context, AsyncSnapshot snapshot) {
          //print(snapshot.hasData);
          //print('hi${snapshot.data![0]}');
          List<Recipe> snapRecipe = [];
          snapshot.data!.forEach((element) {
            Recipe r = element as Recipe;
            snapRecipe.add(r);
          });
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
                    child: Text(
                      '고등어, 밀가루',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
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
