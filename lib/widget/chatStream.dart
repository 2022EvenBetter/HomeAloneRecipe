import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_alone_recipe/screen/groupBuyingDetail_screen.dart';
import 'package:home_alone_recipe/screen/groupChatting.dart';
import 'package:home_alone_recipe/widget/postWidget.dart';
import 'package:home_alone_recipe/provider/userProvider.dart';
import 'package:provider/provider.dart';

import '../models/post.dart';

class Chats extends StatelessWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late UserProvider _userProvider;
    _userProvider = Provider.of<UserProvider>(context);

    Future<String> postTitlebyChatId(String chatId) async {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("Post")
          .where("chatId", isEqualTo: chatId)
          .get();
      String name = "";
      for (var doc in querySnapshot.docs) {
        // Getting data directly
        name = doc.get('Title');
      }
      return name;
    }

    Future<String> lastMessagebyChatId(String chatId) async {
      String route = '/chatrooms/' + chatId + '/messages';
      final querySnapshot = await FirebaseFirestore.instance
          .collection(route)
          .orderBy('sendDate', descending: true)
          .limit(1)
          .get();
      String message = "";
      for (var doc in querySnapshot.docs) {
        // Getting data directly
        message = doc.get('content');
      }
      return message;
    }

    bool isDeleted = false;

    return ListView.builder(
      itemCount: _userProvider.chats.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {

            final querySnapshot=await FirebaseFirestore.instance
                  .collection("Post")
                  .where("chatId", isEqualTo: _userProvider.chats[index]).get();
               for (var doc in querySnapshot.docs) {
                // Getting data directly
                isDeleted = doc.get('isDeleted');
               }
            Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) =>
                MessageListScreen(_userProvider.chats[index],isDeleted)));
            },
          child: Container(
            decoration: BoxDecoration(
              color:Colors.white,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 8, 20, 5),
                  child: Row(
                    children: [
                      Icon(Icons.chat_bubble, color: Colors.blueAccent, size: 60),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder(
                                future:
                                    postTitlebyChatId(_userProvider.chats[index]),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  //해당 부분은 data를 아직 받아 오지 못했을때
                                  if (snapshot.hasData == false) {
                                    return CircularProgressIndicator();
                                  }
                                  //error가 발생하게 될 경우
                                  else if (snapshot.hasError) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Error: ${snapshot.error}',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    );
                                  }
                                  // 데이터를 정상적으로 받아오게 되면
                                  else {
                                    int length = snapshot.data.toString().length;
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        length > 16
                                            ? snapshot.data
                                                    .toString()
                                                    .substring(0, 20) +
                                                "..."
                                            : snapshot.data.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black),
                                      ),
                                    );
                                  }
                                }),
                            FutureBuilder(
                                future: lastMessagebyChatId(
                                    _userProvider.chats[index]),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  //해당 부분은 data를 아직 받아 오지 못했을때
                                  if (snapshot.hasData == false) {
                                    return CircularProgressIndicator();
                                  }
                                  //error가 발생하게 될 경우
                                  else if (snapshot.hasError) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Error: ${snapshot.error}',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    );
                                  }
                                  // 데이터를 정상적으로 받아오게 되면
                                  else {
                                    int length = snapshot.data.toString().length;
                                    return Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(10, 5, 0, 10),
                                      child: Text(
                                        length > 16
                                            ? snapshot.data
                                                    .toString()
                                                    .substring(0, 22) +
                                                "..."
                                            : snapshot.data.toString(),
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.black54),
                                      ),
                                    );
                                  }
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15, top: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          spreadRadius: 0,
                          blurRadius: 2,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    height: 1.0,
                    width: 500.0,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
