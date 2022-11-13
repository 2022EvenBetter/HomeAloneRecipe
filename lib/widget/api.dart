import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;
import 'package:home_alone_recipe/widget/getRecipe.dart';

class Api extends StatefulWidget {
  final List apiResults;
  const Api(this.apiResults, {super.key});

  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {
  bool showWidget = false;

  XmlDocument? xmlData;
  void _callAPI() async {
    final url = Uri.parse(
        'http://211.237.50.150:7080/openapi/a0e05d197e3886ea191fa4f206b3b99dfc004411423b5e5187361ae7e6e651cd/xml/Grid_20150827000000000227_1/1/100?IRDNT_NM=쌀');
// 재료검색 (쌀) => 쌀에 관련된 레시피 코드 리스트 => 리스트를 순회하여 api 호출
    final response = await http.get(url);
    print('Response Status : ${response.statusCode}');
    xmlData = XmlDocument.parse(response.body);
    final wantData = xmlData!
        .findAllElements('RECIPE_ID')
        .map((node) => node.text)
        .forEach((node) {
      widget.apiResults.add(node);
    });
    print(widget.apiResults);
  }

  void _refresh() {
    widget.apiResults.clear();
    print(widget.apiResults);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ElevatedButton(
            onPressed: () {
              _callAPI();
            },
            child: Text('Call API')),
        ElevatedButton(
            onPressed: () {
              _refresh();
            },
            child: Text('refresh')),
      ],
    );
  }
}
