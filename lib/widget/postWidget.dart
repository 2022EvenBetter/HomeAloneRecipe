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

  String curState() {
    if (maxParticipants > curParticipants) {
      return "모집중";
    } else {
      return "모집완료";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, right: 15),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: "${curState()}  ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: curState() == "모집중"
                            ? Palette.blue
                            : Colors.redAccent)),
                TextSpan(
                    text: "$title\n",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black)),
                WidgetSpan(
                  child: Icon(
                    Icons.people,
                  ),
                ),
                TextSpan(
                    text: "  $curParticipants/$maxParticipants명 참여\n",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    )),
                WidgetSpan(
                  child: Icon(
                    Icons.calendar_month,
                  ),
                ),
                TextSpan(
                  text: "  $date $time",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(18, 10, 10, 7),
          height: MediaQuery.of(context).size.width * 0.23,
          width: MediaQuery.of(context).size.width * 0.98,
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: Palette.lightgrey,
                borderRadius: BorderRadius.circular(7.0)),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  content,
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
          padding: EdgeInsets.only(left: 22, right: 5, top: 5),
          child: Text(
            "작성자: $writerName",
            style: TextStyle(fontSize: 13, color: Colors.black, height: 1.0),
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
    );
  }
}
