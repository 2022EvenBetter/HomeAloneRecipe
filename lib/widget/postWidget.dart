import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_alone_recipe/config/palette.dart';

class PostList extends StatelessWidget {
  const PostList(
      this.content,
      this.title,
      this.date,
      this.time,
      this.writerName,
      this.upperCategory,
      this.lowerCategory,
      this.maxParticipants,
      this.curParticipants,
      this.place,
      {Key? key})
      : super(key: key);

  final String content;
  final String title;
  final String date;
  final String time;
  final String writerName;
  final String upperCategory;
  final String lowerCategory;
  final int maxParticipants;
  final int curParticipants;
  final String place;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left:5,right:5),
          child: RichText(
              text: TextSpan(
            children: [
            TextSpan(
                text: title+"\n",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17,color: Colors.black)),
              WidgetSpan(
                child: Icon(Icons.people),
              ),
            TextSpan(
                text: curParticipants.toString() +
                    "/" +
                    maxParticipants.toString() +
                    "명 참여\n",style: TextStyle(
              fontSize: 13,
              color: Colors.black,)),
              WidgetSpan(
                child: Icon(Icons.calendar_month),
              ),
            TextSpan(text: date + " " + time, style: TextStyle(
              fontSize: 13,
              color: Colors.black,
            ),),],
              ),
          ),
        ),

        Container(
          padding: EdgeInsets.all(5),
          height:MediaQuery.of(context).size.width * 0.23 ,
          width: MediaQuery.of(context).size.width * 0.98,
          child: DecoratedBox(
          decoration: BoxDecoration(color: Palette.lightgray,
              borderRadius: BorderRadius.circular(5.0)),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left:10,right:10),
                child: Text(content,
                  style: TextStyle(
                  fontSize: 14,

                ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ),
          ),
        ),
          Padding(
            padding: EdgeInsets.only(left:5,right:5,top:5),
            child: Text("작성자: " + writerName+"\n\n", style: TextStyle(
              fontSize: 13,
              color: Colors.black,
              height: 1.0
            ),),
          ),
      ],
    );
  }
}
