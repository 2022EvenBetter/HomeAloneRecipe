import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';

class ChatBubbles extends StatelessWidget {
  const ChatBubbles(this.message, this.isMe, this.userNickname, this.time,
      {Key? key})
      : super(key: key);

  final String message;
  final bool isMe;
  final String userNickname;
  final Timestamp time;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        (isMe ?
        isMeChatBubble(context) :
        isNotMeChatBubble(context)),
      ],
    );
  }

  Padding isNotMeChatBubble(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
          child: ChatBubble(
            clipper: ChatBubbleClipper4(type: BubbleType.receiverBubble),
            backGroundColor: const Color(0xffFFE603),
            margin: const EdgeInsets.only(top: 20),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userNickname,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    message,
                    style: const TextStyle(color: Colors.black),
                  ),
                  Text(
                    time.toDate().toLocal().toString().substring(5, 16),
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }

  Padding isMeChatBubble(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 5, 5),
          child: ChatBubble(
            clipper: ChatBubbleClipper4(type: BubbleType.sendBubble),
            alignment: Alignment.topRight,
            margin: const EdgeInsets.only(top: 20),
            backGroundColor: Colors.blue,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    time.toDate().toLocal().toString().substring(5, 16),
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
