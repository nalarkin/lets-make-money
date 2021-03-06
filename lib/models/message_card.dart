import 'package:cloud_firestore/cloud_firestore.dart';

class MessageCard {
  Timestamp? timestamp;
  String content;
  String idFrom;
  String idTo;

  bool read;

  MessageCard({
    this.idFrom = '',
    this.idTo = '',
    this.content = '',
    this.timestamp,
    this.read = false,
  });

  factory MessageCard.fromMap(Map<String, dynamic> msgInfo) {
    print("creating message card from map");
    MessageCard res = new MessageCard(
      idFrom: msgInfo['idFrom'],
      idTo: msgInfo['idTo'],
      read: msgInfo['read'],
      timestamp: (msgInfo["timestamp"] as Timestamp),
      content: msgInfo["content"],
    );

    return res;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      "content": content,
      "idFrom": idFrom,
      "idTo": idTo,
      "read": read,
      "timestamp": timestamp
    };
    print("converted MessageCard to map, data below \n $data");
    return data;
  }

  @override
  String toString() {
    return "MessageCard(from:$idFrom  to:$idTo, content:$content  read?:$read)";
  }
}
