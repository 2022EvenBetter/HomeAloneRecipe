import 'dart:developer';
import 'dart:convert';
import 'package:flutter/services.dart';

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

class json1 extends StatefulWidget {
  const json1({super.key});

  @override
  State<json1> createState() => _json1State();
}

class _json1State extends State<json1> {
  List _items = [];

// Fetch content from the json file
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('lib/assets/recipeInfo.json');
    print(response);
    final data = await json.decode(response);
    print(data);
    setState(() {
      _items = data["recipe"];
    });
    print(_items);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          ElevatedButton(
            child: const Text('Load Data'),
            onPressed: readJson,
          ),

          // Display the data loaded from sample.json
          _items.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      if (_items[index]["레시피 코드"] == 1 ||
                          _items[index]["레시피 코드"] == 3 ||
                          _items[index]["레시피 코드"] == 5) {
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            leading: Text('${_items[index]["레시피 코드"]}'),
                            title: Text('${_items[index]["레시피 이름"]}'),
                            subtitle: Text(_items[index]["간략(요약) 소개"]),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                )
              : Text('1')
        ],
      ),
    );
  }
}
