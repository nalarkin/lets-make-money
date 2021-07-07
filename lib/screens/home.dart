import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_talk_money/services/auth.dart';
import 'package:lets_talk_money/services/database.dart';
import 'package:lets_talk_money/utils/widgets.dart';
import 'package:provider/provider.dart';






class Home extends StatelessWidget {
  static const String routeName = "/home";
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? currUser = Provider.of<User?>(context);
    AuthService _auth = AuthService();
    print(currUser);
    return Scaffold(
      appBar: AppBar(
        title: Text(currUser?.displayName ?? ''),
        actions: [
          IconButton(
              // onPressed: () => createNewConvo(context),
              onPressed: () => null,
              icon: Icon(
                Icons.add,
                size: 30,
              ))
        ],
      ),
      body: Container(
          child: Center(
        child: Column(
          children: [
            Text("$currUser"),
            MaterialButton(
              onPressed: () async => await _auth.signOut(),
              child: Text("Sign out"),
            ),
            MaterialButton(
              onPressed: () async =>
                  DatabaseService().createUserInDatabase(currUser),
              child: Text("create user"),
            )
          ],
        ),
      )),
    );
  }
}
// class Home extends StatelessWidget {
//   static const String routeName = "/home";
//   const Home({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     User? currUser = Provider.of<User?>(context);
//     AuthService _auth = AuthService();
//     print(currUser);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(currUser?.displayName ?? ''),
//         actions: [
//           IconButton(
//               // onPressed: () => createNewConvo(context),
//               onPressed: () => null,
//               icon: Icon(
//                 Icons.add,
//                 size: 30,
//               ))
//         ],
//       ),
//       body: Container(
//           child: Center(
//         child: Column(
//           children: [
//             Text("$currUser"),
//             MaterialButton(
//               onPressed: () async => await _auth.signOut(),
//               child: Text("Sign out"),
//             ),
//             MaterialButton(
//               onPressed: () async =>
//                   DatabaseService().createUserInDatabase(currUser),
//               child: Text("create user"),
//             )
//           ],
//         ),
//       )),
//     );
//   }
// }

// void createNewConvo(BuildContext context) {
//     Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(
//         builder: (BuildContext context) => NewMessageProvider()));
//   }

Future<void> printUser() async {
  AuthService _auth = AuthService();
  User? firebaseUser = await _auth.firstLogin();
  print(firebaseUser);
}
