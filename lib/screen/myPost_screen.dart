
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_alone_recipe/provider/userProvider.dart';
import 'package:provider/provider.dart';
import 'package:home_alone_recipe/screen/groupBuyingDetail_screen.dart';
import 'package:home_alone_recipe/widget/postWidget.dart';
import '../models/post.dart';
import '../widget/postStream.dart';

class MyPostScreen extends StatefulWidget {
  const MyPostScreen({super.key});

  @override
  State<MyPostScreen> createState() => _MyPostScreen();
}

class _MyPostScreen extends State<MyPostScreen> {
  late UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    print(_userProvider.uid);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '내가 쓴 공동구매글',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 3.0,
        backgroundColor: Colors.white,
      ),

        body: Container(
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Expanded(
                  child: MyPostBuilder(),
                ),
              ),

            ]))
    );
  }
}


class MyPostBuilder extends StatefulWidget {
  const MyPostBuilder({super.key});

  @override
  State<MyPostBuilder> createState() => _MyPostBuilder();
}

class _MyPostBuilder extends State<MyPostBuilder> {
  @override
  Widget build(BuildContext context) {
    late UserProvider _userProvider;
    _userProvider = Provider.of<UserProvider>(context);
    Query<Map<String, dynamic>> postFilterLocation = FirebaseFirestore.instance
        .collection("Post")
        .where('Uid', isEqualTo: _userProvider.uid);

    Future<String> get_Id(DocumentReference doc_ref) async {
      DocumentSnapshot docSnap = await doc_ref.get();
      var doc_id2 = docSnap.reference.id;
      return doc_id2;
    }

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
            return GestureDetector(
              onTap: () {
                Post post = Post.fromQuerySnapshot(postDocs[index]);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GroupBuyingDetailPage(post)));
              },
              child: PostList(
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
              ),
            );
          },
        );
      },
    );
  }
}



//

