import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_talk_money/models/member.dart';
import 'package:lets_talk_money/screens/user_row.dart';
import 'package:provider/provider.dart';


class NewMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);
    final List<Member> userDirectory = Provider.of<List<Member>>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Select Contact')),
      body: userDirectory != null
          ? ListView(
              shrinkWrap: true, children: getListViewItems(userDirectory, user))
          : Container(),
    );
  }

  List<Widget> getListViewItems(List<Member> userDirectory, User? user) {
    final List<Widget> list = <Widget>[];
    for (Member contact in userDirectory) {
      if (contact.id != user?.uid) {
        list.add(UserRow(uid: user?.uid ?? '', contact: contact));
        list.add(Divider(thickness: 1.0));
      }
    }
    return list;
  }
}