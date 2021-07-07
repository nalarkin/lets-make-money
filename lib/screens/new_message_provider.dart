// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:lets_talk_money/services/database.dart';
// import 'package:provider/provider.dart';

// class NewMessageProvider extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider<List<User?>>.value(
//       value: DatabaseService().streamUsers(),
//       initialData: [],
//       child: NewMessage(),
//     );
//   }
// }