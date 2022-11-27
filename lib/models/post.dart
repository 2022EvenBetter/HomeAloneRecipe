import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? upperCategory;
  String? lowerCategory;
  String? title;
  String? content;
  int? maxParticipants;
  int? curParticipants;
  String? date;
  String? time;
  String? meetingPlace;
  String? writerName;
  List<String>? userLocation;

  Post({
    this.upperCategory,
    this.lowerCategory,
    this.title,
    this.content,
    this.maxParticipants,
    this.curParticipants,
    this.date,
    this.time,
    this.meetingPlace,
    this.writerName,
    this.userLocation,
  });

  Post.fromJson(dynamic json) {
    upperCategory = json['UpperCategory'];
    lowerCategory = json['LowerCategory'];
    title = json['Title'];
    content = json['Content'];
    maxParticipants = json['maxParticipants'];
    curParticipants = json['curParticipants'];
    date = json['Date'];
    time = json['Time'];
    meetingPlace = json['Place'];
    writerName = json['WriterName'];
    userLocation = json['UserLocation'].cast<String>();
  }

  Post.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data());

  Post.fromQuerySnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
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
        'writerName': writerName,
      };
}
