// import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  // String author;
  String timestamp;
  String content;
  String idFrom;
  String idTo;
  // String convoID;
  bool read;
  Map<dynamic, dynamic>? lastMessage;
  List<String>? users;

// sendMessage(convoID, uid, contact.id, content,
//           DateTime.now().millisecondsSinceEpoch.toString());

  Message({
    // this.convoID = '',
    this.idFrom = '',
    this.idTo = '',
    this.content = '',
    this.timestamp = '',
    this.read = false,
    this.lastMessage,
    this.users,
   
  });

  factory Message.fromMap(Map<String, dynamic> userInfo) {

    
    // userInfo {
    //   lastMessage {
    //         content: "hey"
    //         idFrom: ""
    //         idTo: ""
    //         read: false
    //         timestamp: ""

    //   },
    //   users ["nautsyrnutysrntyuf", "lufmr9;lkftulrakmtf"]
    // }
    

    
    Message res = new Message(
      idFrom: userInfo['lastMessage']['idFrom'],
      idTo: userInfo['lastMessage']['idTo'],
      read: userInfo['lastMessage']['read'],
      timestamp: userInfo['lastMessage']["date"].toString(),
      content: userInfo['lastMessage']["content"],
      lastMessage: userInfo['lastMessage'] as Map<String, dynamic>,
      users: userInfo['users'],
    );
    print("Created $res");
    return res;
  }

  @override
  String toString() {
    return "MessageCard($idFrom to $idTo, $content)";
  }
}
