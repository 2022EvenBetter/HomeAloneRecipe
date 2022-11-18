import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;

class GetRecipe extends StatelessWidget {
  final List ingredient;
  final i;
  const GetRecipe(this.ingredient, this.i, {super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference recipe =
        FirebaseFirestore.instance.collection("recipe");

    void gettt() {
      recipe.where("레시피 코드", isEqualTo: 100).get().then(
          (res) => print(res.docs[0].data()),
          onError: (e) => print("error"));
    }


    return FutureBuilder<QuerySnapshot>(
      future: recipe.where("레시피 코드", isEqualTo: int.parse(ingredient[i])).get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        print(i);
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;

              print(data);
              return (ListTile(
                title: Text('${data['레시피 코드']}'),
                subtitle: Text(data['간략(요약) 소개']),
                trailing: Image.network(data['대표이미지 URL']),
              ));
            }).toList(),
          );
        }
        return Text("loading");
      },
    );
  }
}