// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:lets_talk_money/models/member.dart';
// import 'package:lets_talk_money/models/message.dart';
// import 'package:lets_talk_money/screens/home_builder.dart';
// import 'package:lets_talk_money/services/database.dart';
// import 'package:provider/provider.dart';

// class ConversationProvider extends StatelessWidget {
//   const ConversationProvider({
//     // Key key,
//     required this.user,
//   });

//   final User? user;

//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider<List<Message>>.value(
//         value: DatabaseService().streamConversations(user?.uid ?? ''),
//         initialData: [],
//         child: ConversationDetailsProvider(user: user));
//   }
// }

// class ConversationDetailsProvider extends StatelessWidget {
//   const ConversationDetailsProvider({
//     required this.user,
//   });

//   final User? user;

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//     // return StreamProvider<List<Member>>.value(
//     //     value: DatabaseService()
//     //         .getUsersByList(getUserIds(Provider.of<List<Message>>(context))),
//     //     initialData: [],
//     //     child: HomeBuilder());
//   }

//   // this determines which way the messages orient
//   List<String> getUserIds(List<Message> _convos) {
//     final List<String> users = <String>[];
//     if (_convos != null) {
//       for (Message c in _convos) {
//         c.idFrom != (user?.uid ?? '') ? users.add(c.idFrom) : users.add(c.idTo);
//       }
//     }
//     return users;
//   }
// }
