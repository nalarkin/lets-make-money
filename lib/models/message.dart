// import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  // String author;
  String timestamp;
  String content;
  String idFrom;
  String idTo;
  // String convoID;
  bool read;

// sendMessage(convoID, uid, contact.id, content,
//           DateTime.now().millisecondsSinceEpoch.toString());

  Message({
    // this.convoID = '',
    this.idFrom = '',
    this.idTo = '',
    this.content = '',
    this.timestamp = '',
    this.read = false,
  });

// 'lastMessage': <String, dynamic>{
//         'idFrom': id,
//         'idTo': pid,
//         'timestamp': timestamp,
//         'content': content,
//         'read': false
//       },
//       'users': <String>[id, pid]

  factory Message.fromMap(Map<String, dynamic> userInfo) {
    Message res = new Message(
      idFrom: userInfo['idFrom'],
      idTo: userInfo['idTo'],
      read: userInfo['read'],
      timestamp: userInfo["date"].toString(),
      content: userInfo["content"],
    );
    print("Created $res");
    return res;
  }

  @override
  String toString() {
    return "MessageCard($idFrom to $idTo, $content)";
  }
}
