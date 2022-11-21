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

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;
  const RecipeDetailPage(this.recipe, {super.key});

  @override
  Widget build(BuildContext context) {
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
                              // icon: isScrap
                              //     ? Icon(Icons.favorite)
                              //     : Icon(Icons
                              //         .favorite_outline),
                              icon: Icon(Icons.favorite),
                              focusColor: Colors.amber,
                              isSelected: false,
                              selectedIcon: Icon(Icons.favorite_border),
                              onPressed: () {
                                // setState(() {
                                //   isScrap = !isScrap;
                                // });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Text('55'),
                          ),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var i = 0; i < recipe.recipe.length; i++)
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                '${i + 1} : ${recipe.recipe[i]}',
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
