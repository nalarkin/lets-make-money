import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_talk_money/models/member.dart';
import 'package:lets_talk_money/models/message.dart';
import 'package:async/async.dart';

class DatabaseService {
  final _firestoreInstance = FirebaseFirestore.instance;

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
  static const String MSG_AUTHOR_FIELD = 'author';
  static const String MSG_CONTENT_FIELD = 'content';
  static const String MSG_DATE_FIELD = 'date';
  static const String MSG_ROOM_FIELD = 'room';
  // static const List ALL_ROOMS = [
  //   GAMES_ROOM,
  //   BUSINESS_ROOM,
  //   HEALTH_ROOM,
  //   STUDY_ROOM
  // ];

  Future createUserInDatabase(User? currUser) async {
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

  // Stream<List<User>> streamUsers() {
  //   return _firestoreInstance.collection(USERS_COLLECTION)
  //   .snapshots().map((event) => null)

  //   => list.docs.map((DocumentSnapshot snap) => Member.fromMap(snap.data()))).toList();
  // }

  Stream<List<Member>> streamUsers() {
    return _firestoreInstance.collection(USERS_COLLECTION).snapshots().map(
        (QuerySnapshot list) => list.docs
            .map((DocumentSnapshot snap) =>
                Member.fromMap(snap.data() as Map<String, dynamic>))
            .toList());
    // );
  }
  // Stream get getMessages => _firestoreInstance.collection(MSG_COLLECTION).doc(convoID).collection(convoID).orderBy('timestamp', descending: true).limit(20).snapshots(),

  void updateMessageRead(DocumentSnapshot document, String convoID) {
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
  Stream<List<Message>> streamConversations(String uid) {
    return _firestoreInstance
        .collection('messages')
        .orderBy('lastMessage.timestamp', descending: true)
        .where('users', arrayContains: uid)
        .snapshots()
        .map((QuerySnapshot list) => list.docs
            .map((DocumentSnapshot doc) =>
                Message.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Stream<List<Member>> get streamMembers => _firestoreInstance
      .collection(USERS_COLLECTION)
      .snapshots()
      .map(convertUsersToMembers);

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

  // Future createMessageInDatabase(MessageCard msgCardToAdd) async {
  //   try {
  //     // checks to make sure room collection exists
  //     if (ALL_ROOMS.contains(msgCardToAdd.room)) {
  //       _firestoreInstance
  //           .collection(ROOM_COLLECTION)
  //           .doc(msgCardToAdd.room)
  //           .collection(MSG_COLLECTION)
  //           .add({
  //         MSG_AUTHOR_FIELD: msgCardToAdd.author,
  //         MSG_CONTENT_FIELD: msgCardToAdd.content,
  //         MSG_DATE_FIELD: msgCardToAdd.date,
  //         MSG_ROOM_FIELD: msgCardToAdd.room,
  //       });
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

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

  Future updateUsername(String uid, String newUsername) async {
    _firestoreInstance
        .collection(USERS_COLLECTION)
        .doc(uid)
        .update({USER_USERNAME_FIELD: newUsername})
        .then((value) => print('Updated username to $newUsername.'))
        .catchError((error) => print('Failed to create user: $error'));
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
