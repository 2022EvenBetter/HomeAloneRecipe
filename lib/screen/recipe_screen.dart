import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;
import 'package:home_alone_recipe/widget/getRecipe.dart';
import 'package:home_alone_recipe/widget/api.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  List<dynamic> apiResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Api(apiResults),
          // for (var j = 0; j < apiResults.length; j++)
          //   Expanded(child: GetRecipe(apiResults, j)),
        ],
      ),
    );
    ;
  }
}
