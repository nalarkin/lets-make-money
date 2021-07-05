import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String author;
  DateTime? date;
  String content;
  String room;

  Message({
    this.author = '',
    this.content = '',
    this.room = '',
    this.date,
  });



  factory Message.fromMap(Map<String, dynamic> userInfo) {
    Message res = new Message(
      author: userInfo["author"],
      date: (userInfo["date"] as Timestamp).toDate(),
      content: userInfo["content"],
      room: userInfo["room"],
    );
    print("Created $res");
    return res;
  }

  @override
  String toString() {
    return "MessageCard($author, $content, $date)";
  }
}
