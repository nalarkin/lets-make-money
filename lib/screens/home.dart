import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_talk_money/services.dart/auth.dart';
import 'package:lets_talk_money/utils/widgets.dart';

class Home extends StatelessWidget {
  static const String routeName = "/home";
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Column(
        children: [
          Text("HELLO WORLD"),
          StyledButton(text: "firstSignin()", onPressed: printUser)
        ],
      ),
    ));
  }
}

Future<void> printUser() async {
  AuthService _auth = AuthService();
  User? firebaseUser = await _auth.firstLogin();
  print(firebaseUser);
}
