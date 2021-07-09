import 'package:lets_talk_money/models/message_card.dart';

class Conversation {
  String id;
  List<dynamic> users;
  // Map<String, dynamic> lastMessage;
  MessageCard lastMessage;

  Conversation(
      {required this.id, required this.users, required this.lastMessage});

  factory Conversation.fromMap(String docID, Map<String, dynamic> convoData) {
    try {
      Conversation currConversation = Conversation(
        id: docID,
        users: convoData["participants"],
        lastMessage: MessageCard.fromMap(convoData["lastMessage"]),
      );
      return currConversation;
    } catch (e) {
      print("ERROR creating conversation from map.");
      print("docID: $docID | convoData: $convoData");
      print(StackTrace.current);
      // throw (e);
      return Conversation(id: 'nul', users: [], lastMessage: MessageCard());
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Conversation(id: $id users: $users lastMessage: $lastMessage)';
  }
}
