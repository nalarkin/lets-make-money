// import 'package:flutter/material.dart';
// import 'package:lets_talk_money/models/member.dart';
// import 'package:lets_talk_money/screens/new_conversation.dart';
// import 'package:lets_talk_money/utils/helper.dart';

// class UserRow extends StatelessWidget {
//   const UserRow({required this.uid, required this.contact});
//   final String uid;
//   final Member contact;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => createConversation(context),
//       child: Container(
//           margin: EdgeInsets.all(10.0),
//           padding: EdgeInsets.all(10.0),
//           child: Center(
//               child: Text(contact.username,
//                   style:
//                       TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)))),
//     );
//   }

// //   void createConversation(BuildContext context) {
// //     String convoID = HelperFunctions.getConvoID(uid, contact.id);
// //     Navigator.of(context).pushReplacement(MaterialPageRoute(
// //         builder: (BuildContext context) => NewConversation(
// //             uid: uid, contact: contact, convoID: convoID)));
// //   }
// // }