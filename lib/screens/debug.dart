import 'package:flutter/material.dart';
import 'package:lets_talk_money/services.dart/auth.dart';

class Debug extends StatelessWidget {
  static const String routeName = '/debug';
  const Debug({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    return Scaffold(
        body: MaterialButton(
      onPressed: () async => await _auth.signInAnon(),
      child: Text("sing in anon"),
    ));
  }
}
