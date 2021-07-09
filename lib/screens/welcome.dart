import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_talk_money/screens/debug.dart';
import 'package:lets_talk_money/screens/home.dart';
import 'package:lets_talk_money/services/auth.dart';
import 'package:provider/provider.dart';

class Welcome extends StatelessWidget {
  static const String routeName = '/welcome';
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    User? currUser = Provider.of<User?>(context);
    print(currUser);
    if (currUser == null) {
      _auth.signInAnon();
      return Debug();
    } else {
      return Home();
    }
  }
}
