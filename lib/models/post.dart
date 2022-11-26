import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? upperCategory;
  String? lowerCategory;
  String? title;
  String? content;
  int? maxParticipants;
  String? date;
  String? time;
  String? meetingPlace;
  int? curParticipants;

  Post(
      {this.upperCategory,
      this.lowerCategory,
      this.title,
      this.content,
      this.maxParticipants,
        this.curParticipants,
      this.date,
      this.time,
      this.meetingPlace});

  Post.fromJson(dynamic json) {
    upperCategory = json['upperCategory'];
    lowerCategory = json['lowerCategory'];
    title = json['title'];
    content = json['content'];
    maxParticipants = json['maxParticipants'];
    curParticipants=json['curParticipants'];
    date = json['date'];
    time = json['time'];
    meetingPlace = json['meetingPlace'];
  }

  Post.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data());

  Post.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data());

  Map<String, dynamic> toJson() => {
        'upperCategory': upperCategory,
        'lowerCategory': lowerCategory,
        'title': title,
        'content': content,
        'maxParticipants': maxParticipants,
        'curParticipants': curParticipants,
        'date': date,
        'time': time,
        'meetingPlace': meetingPlace,
      };
}
