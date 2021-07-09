import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_talk_money/models/conversation.dart';
import 'package:lets_talk_money/models/member.dart';
import 'package:lets_talk_money/models/message.dart';
import 'package:async/async.dart';
import 'package:lets_talk_money/models/message_card.dart';
import 'package:lets_talk_money/utils/helper.dart';

class DatabaseService {
  final _firestoreInstance = FirebaseFirestore.instance;

  // final _firestoreInstance = FirebaseFirestore.instance;

  // _firestoreInstance.settings = const Settings(
  //             host: 'localhost:8080',
  //             persistenceEnabled: false,
  //           );

  DatabaseService();

  static const String USERS_COLLECTION = "users";
  static const String USER_FIRSTNAME_FIELD = "firstName";
  static const String USER_LASTNAME_FIELD = "lastName";
  static const String USER_ID_FIELD = "id";
  static const String USER_EMAIL_FIELD = "email";
  static const String USER_DATE_REGISTERED_FIELD = "dateRegistered";
  static const String USER_USERNAME_FIELD = "username";

  // static const String ROOM_COLLECTION = 'allRooms';
  // static const String GAMES_ROOM = 'gamesRoom';
  // static const String BUSINESS_ROOM = 'businessRoom';
  // static const String STUDY_ROOM = 'studyRoom';
  // static const String HEALTH_ROOM = 'healthRoom';
  static const String MSG_COLLECTION = 'messages';

  static const String MSG_ID_FROM = 'idFrom';
  static const String MSG_LAST_MESSAGE = 'lastMessage';
  static const String MSG_USER_ARRAY = 'participants';
  static const String MSG_CONTENT = 'content';
  static const String MSG_ID_TO = 'idTo';
  static const String MSG_TIMESTAMP = 'timestamp';
  static const String MSG_READ = 'read';
  // static const List ALL_ROOMS = [
  //   GAMES_ROOM,
  //   BUSINESS_ROOM,
  //   HEALTH_ROOM,
  //   STUDY_ROOM
  // ];

  Future createUserInDatabase(User? currUser) async {
    // //FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);

    print("inside database creation user is : $currUser");
    if (currUser != null) {
      _firestoreInstance
          .collection(USERS_COLLECTION)
          .doc(currUser.uid)
          .set({
            USER_EMAIL_FIELD: "",
            USER_FIRSTNAME_FIELD: "",
            USER_LASTNAME_FIELD: "",
            USER_ID_FIELD: currUser.uid,
            USER_DATE_REGISTERED_FIELD: Timestamp.now(),
            USER_USERNAME_FIELD: "Guest",
          })
          .then((value) => print('Guest created in Firestore Database.'))
          .catchError((error) => print('Failed to create user: $error'));
    } else {
      print('User was null, so could not complete createUserInDatabase()');
    }
  }

  List<MessageCard> convertToMessageList(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<MessageCard> _healthMessageList = [];
    snapshot.docs.forEach((element) {
      _healthMessageList.add(MessageCard.fromMap(element.data()));
    });
    return _healthMessageList;
  }

  // Stream<List<User>> streamUsers() {
  //   return _firestoreInstance.collection(USERS_COLLECTION)
  //   .snapshots().map((event) => null)

  //   => list.docs.map((DocumentSnapshot snap) => Member.fromMap(snap.data()))).toList();
  // }

  Stream<List<Member>> streamUsers() {
    // //FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    return _firestoreInstance.collection(USERS_COLLECTION).snapshots().map(
        (QuerySnapshot list) => list.docs
            .map((DocumentSnapshot snap) =>
                Member.fromMap(snap.data() as Map<String, dynamic>))
            .toList());
    // );
  }
  // Stream get getMessages => _firestoreInstance.collection(MSG_COLLECTION).doc(convoID).collection(convoID).orderBy('timestamp', descending: true).limit(20).snapshots(),

  void updateMessageRead(DocumentSnapshot document, String convoID) {
    // //FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('messages')
        .doc(convoID)
        .collection(convoID)
        .doc(document.id);
    documentReference
        .set(<String, dynamic>{'read': true}, SetOptions(merge: true));
  }

  //  this represents message collection (not subcollection!)
  // lastMessage adn users array are visible to this
  Stream<List<Conversation>> streamConversations(String uid) {
    try {
      // //FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      if (uid.isEmpty) {
        print("ERROR. streamConverations(String uid) UID IS EMPTY");
        throw (StackTrace.current);
      }
      return _firestoreInstance
          .collection(MSG_COLLECTION)
          .orderBy('$MSG_LAST_MESSAGE.$MSG_TIMESTAMP', descending: true)
          .where(MSG_USER_ARRAY, arrayContains: uid)
          .snapshots()
          .map((QuerySnapshot list) => list.docs
              .map((DocumentSnapshot doc) => Conversation.fromMap(
                  doc.id, doc.data() as Map<String, dynamic>))
              .toList());
    } catch (e) {
      print("ERROR Occured in Database().streamConversations");
      print("String uid: $uid");
      print(StackTrace.current);
      print(e);
      throw (e);
    }
  }

  Stream<List<String>> convertConversationsToMembers(
      User? currUser, List<Conversation> convoList) {
    List<String> _senders = grabMostRecentSender(currUser, convoList);
    print(convoList.toString());
    print(_senders.toString());
    List<Stream<String>> res = [];
    // //FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    for (String id in _senders) {
      res.add(_firestoreInstance
          .collection(USERS_COLLECTION)
          .doc(id)
          .snapshots()
          // .map((event) => Member.fromMap(event.data())));
          .map((event) => (Member.fromMap(event.data())).username));
    }
    return StreamZip<String>(res).asBroadcastStream();
  }

  List<String> grabMostRecentSender(
      User? currUser, List<Conversation> convoList) {
    List<String> _senders = [];
    String currUserUID = currUser?.uid ?? '';
    assert(currUserUID.isNotEmpty);
    for (Conversation convo in convoList) {
      if (convo.lastMessage.idFrom == currUserUID) {
        _senders.add(currUserUID);
      } else {
        _senders.add(convo.lastMessage.idFrom);
      }
    }
    return _senders;
  }

  Stream<List<Member>> get streamMembers {
    //FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    return _firestoreInstance
        .collection(USERS_COLLECTION)
        .snapshots()
        .map(convertUsersToMembers);
  }

  List<Member> convertUsersToMembers(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<Member> _memberList = [];
    snapshot.docs.forEach((element) {
      _memberList.add(Member.fromMap(element.data()));
    });
    return _memberList;
  }

  // Stream<List<Member>> getUsersByList(List<String> userIds) {
  //   final List<Stream<Member>> streams = [];
  //   for (String id in userIds) {
  //     streams.add(_firestoreInstance
  //         .collection('users')
  //         .doc(id)
  //         .snapshots()
  //         .map((DocumentSnapshot<Map<String, dynamic>> snap) =>
  //             Member.fromMap(snap.data())));
  //   }
  //   return StreamZip<Member>(streams).asBroadcastStream();
  // }

  Future createMessageInDatabase(MessageCard msgCardToAdd) async {
    try {
      // checks to make sure room collection exists
      String convoID =
          HelperFunctions.getConvoID(msgCardToAdd.idFrom, msgCardToAdd.idTo);
      Map<String, dynamic> messageInfo = msgCardToAdd.toMap();
      //FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      await _firestoreInstance
          .collection(MSG_COLLECTION)
          .doc(convoID)
          .collection(convoID)
          .add(messageInfo);
      //     .add({
      //   MSG_CONTENT: msgCardToAdd.content,
      //   MSG_ID_FROM: msgCardToAdd.idFrom,
      //   MSG_ID_TO: msgCardToAdd.idTo,
      //   MSG_READ: msgCardToAdd.read,
      //   MSG_TIMESTAMP: msgCardToAdd.timestamp,
      // });
      print("adding message to firestore");
      await _firestoreInstance.collection(MSG_COLLECTION).doc(convoID).set({
        MSG_LAST_MESSAGE: messageInfo,
        MSG_USER_ARRAY: [msgCardToAdd.idFrom, msgCardToAdd.idTo],
      });
      print("updated last message to $msgCardToAdd");
      //     .set({
      //   MSG_CONTENT: msgCardToAdd.content,
      //   MSG_ID_FROM: msgCardToAdd.idFrom,
      //   MSG_ID_TO: msgCardToAdd.idTo,
      //   MSG_READ: msgCardToAdd.read,
      //   MSG_TIMESTAMP: msgCardToAdd.timestamp,

      // });
      // }
    } catch (e) {
      print(e);
    }
  }

  // Future<List<MessageCard>> getAllHealthMessages() async {
  //   List<MessageCard> _messageList = [];
  //   print("trying to gather messages...");
  //   try {
  //     _firestoreInstance
  //         .collection(ROOM_COLLECTION)
  //         .doc(HEALTH_ROOM)
  //         .collection(MSG_COLLECTION)
  //         .get()
  //         .then((res) {
  //       res.docs.forEach((element) {
  //         // print(MessageCard.fromMap(element.data()));
  //         _messageList.add(MessageCard.fromMap(element.data()));
  //         print('list is now $_messageList');
  //       });
  //       return _messageList;
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  //   return _messageList;
  // }

  // List<MessageCard> convertToMessageList(
  //     QuerySnapshot<Map<String, dynamic>> snapshot) {
  //   List<MessageCard> _healthMessageList = [];
  //   snapshot.docs.forEach((element) {
  //     _healthMessageList.add(MessageCard.fromMap(element.data()));
  //   });
  //   return _healthMessageList;
  // }

  // Stream<List<MessageCard>> get healthMessages => _firestoreInstance
  //     .collection(ROOM_COLLECTION)
  //     .doc(HEALTH_ROOM)
  //     .collection(MSG_COLLECTION)
  //     .orderBy("date", descending: true)
  //     // .limit(20)
  //     .snapshots()
  //     .map(convertToMessageList);

  // Stream<List<MessageCard>> get gamesMessages => _firestoreInstance
  //     .collection(ROOM_COLLECTION)
  //     .doc(GAMES_ROOM)
  //     .collection(MSG_COLLECTION)
  //     .orderBy("date", descending: true)
  //     // .limit(20)
  //     .snapshots()
  //     .map(convertToMessageList);

  Future updateUsername(User? currUser, String newUsername) async {
    //FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    String uid = currUser?.uid ?? 'Guest';
    _firestoreInstance
        .collection(USERS_COLLECTION)
        .doc(uid)
        .update({USER_USERNAME_FIELD: newUsername})
        .then((value) => print('Updated username to $newUsername.'))
        .catchError((error) => print('Failed to create user: $error'));
    await currUser?.updateDisplayName(newUsername);
    currUser?.reload();
  }

  // Stream<List<MessageCard>> get businessMessages => _firestoreInstance
  //     .collection(ROOM_COLLECTION)
  //     .doc(BUSINESS_ROOM)
  //     .collection(MSG_COLLECTION)
  //     .orderBy("date", descending: true)
  //     // .limit(20)
  //     .snapshots()
  //     .map(convertToMessageList);

  // Stream<List<MessageCard>> get studyMessages => _firestoreInstance
  //     .collection(ROOM_COLLECTION)
  //     .doc(STUDY_ROOM)
  //     .collection(MSG_COLLECTION)
  //     .orderBy("date", descending: true)
  //     // .limit(20)
  //     .snapshots()
  //     .map(convertToMessageList);

  // Stream<Member?> getMember(User? currUser) {
  //   return _firestoreInstance
  //       .collection(USERS_COLLECTION)
  //       .doc(currUser?.uid)
  //       .snapshots()
  //       .map((event) => Member.fromMap(event.data()));
  // }

  // Stream<Member?> currFirestoreMember(User? currUser) {
  //   return _firestoreInstance
  //       .collection(USERS_COLLECTION)
  //       .doc(currUser?.uid)
  //       .snapshots()
  //       .map((event) => Member.fromMap(event.data()));
  // }
}
