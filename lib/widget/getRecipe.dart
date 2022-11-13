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

    //Future fut = recipe.where("레시피 코드", isEqualTo: 1).get();

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
          // snapshot.data!.docs[0].data
          // return Padding(
          //   padding: EdgeInsets.all(10.0),
          //   child: Text(snapshot.data!.docs[0].data().toString()),
          // );
        }
        return Text("loading");
      },
    );
  }
}

// class Recipe extends StatefulWidget {
//   final List ingredient;
//   const Recipe(this.ingredient, {super.key});

//   @override
//   State<Recipe> createState() => _RecipeState();
// }

// class _RecipeState extends State<Recipe> {
//   CollectionReference recipe = FirebaseFirestore.instance.collection("recipe");

//   //recipe.get().then((res) => print("1"));

//   @override
//   Widget build(BuildContext context) {
//     final Stream<QuerySnapshot> recipe =
//         FirebaseFirestore.instance.collection("recipe").snapshots();

//     CollectionReference rr = FirebaseFirestore.instance.collection("recipe");
//     var stream = rr.where('레시피 코드', whereIn: [1, 2]);

//     // for (var i = 1; i < 2; i++) {
//     //   stream =
//     //       stream.where('레시피 코드', isEqualTo: int.parse(widget.ingredient[i]));
//     // }

//     Stream<QuerySnapshot> streamQuery = stream.snapshots();

//     Stream<QuerySnapshot> r =
//         FirebaseFirestore.instance.collection("recipe").snapshots();

//     List<int> allNum = [];
//     QuerySnapshot all;
//     final list = <int>[];
//     var j;

//     void getAllNum() {
//       rr.get().then(
//           (res) => {
//                 for (var i = 0; i < res.docs.length; i++)
//                   {allNum.add(res.docs[i].get('레시피 코드'))},
//                 //print(allNum)
//               },
//           onError: (e) => print("error"));
//     }

//     return StreamBuilder<QuerySnapshot>(
//         stream: r,
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           // print('1${snapshot.data!.docs}');
//           // print('hi${widget.ingredient[0]}');
//           getAllNum();
//           return ListView(
//             children: snapshot.data!.docs.map((DocumentSnapshot document) {
//               Map<String, dynamic> data =
//                   document.data()! as Map<String, dynamic>;
//               if (data['레시피 코드'] == widget.ingredient) {
//                 print("find");
//               }
//               return (ListTile(
//                 title: Text('${data['레시피 코드']}'),
//                 subtitle: Text(data['간략(요약) 소개']),
//                 trailing: Image.network(data['대표이미지 URL']),
//               ));
//             }).toList(),
//           );
//         });
//   }
// }