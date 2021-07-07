class Conversation {
  String id;
  List<String> users;
  Map<String, dynamic> lastMessage;

  Conversation(
      {required this.id, required this.users, required this.lastMessage});

  factory Conversation.fromMap(String docID, Map<String, dynamic> convoData) {
    try {
      Conversation currConversation = Conversation(
        id: docID,
        users: convoData["users"] as List<String>,
        lastMessage: convoData["lastMessage"] as Map<String, dynamic>,
      );
      return currConversation;
    } catch (e) {
      print("ERROR creating conversation from map.");
      print("docID: $docID | convoData: $convoData");
      print(StackTrace.current);
      throw (e);
    }
  }
}
