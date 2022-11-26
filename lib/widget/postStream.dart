import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_alone_recipe/widget/postWidget.dart';
import 'package:home_alone_recipe/provider/userProvider.dart';
import 'package:provider/provider.dart';

class Posts extends StatelessWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late UserProvider _userProvider;
    _userProvider = Provider.of<UserProvider>(context);
    Query<Map<String, dynamic>> postFilterLocation = FirebaseFirestore.instance
        .collection("Post")
        .where("UserLocation",
            arrayContains: _userProvider.locations[_userProvider.scope]);
    return StreamBuilder(
      stream: postFilterLocation.snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final postDocs = snapshot.data!.docs;

        return ListView.builder(
          itemCount: postDocs.length,
          itemBuilder: (context, index) {
            return PostList(
              postDocs[index]['Content'],
              postDocs[index]['Title'],
              postDocs[index]['Date'],
              postDocs[index]['Time'],
              postDocs[index]['WriterName'],
              postDocs[index]['UpperCategory'],
              postDocs[index]['LowerCategory'],
              postDocs[index]['maxParticipants'],
              postDocs[index]['curParticipants'],
              postDocs[index]['Place'],
            );
          },
        );
      },
    );
  }
}
