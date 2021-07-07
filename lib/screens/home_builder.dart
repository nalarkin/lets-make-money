import 'package:chat_app/models/convo.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/screens/messaging/widgets/convoWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/services/authentication.dart';
import 'package:lets_talk_money/models/member.dart';
import 'package:lets_talk_money/models/message.dart';
import 'package:lets_talk_money/screens/new_message_provider.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/providers/newMessageProvider.dart';

class HomeBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User? firebaseUser = Provider.of<User?>(context);
    final List<Message> _convos = Provider.of<List<Message>>(context);
    final List<Member> _users = Provider.of<List<Member>>(context);
    return Scaffold(
        appBar: AppBar(
            title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
                onPressed: Authentication.handleLogout,
                icon: Icon(Icons.first_page, size: 30)),
            Text("${firebaseUser?.displayName}",
                style: TextStyle(fontSize: 18)),
            IconButton(
                onPressed: () => createNewMessage(context),
                icon: Icon(Icons.add, size: 30))
          ],
        )),
        body: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: getWidgets(context, firebaseUser, _convos, _users)));
  }

  void createNewMessage(BuildContext context) {
    Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => NewMessageProvider()));
  }

  Map<String, Member> getUserMap(List<Member> users) {
    final Map<String, Member> userMap = Map();
    for (User u in users) {
      userMap[u.id] = u;
    }
    return userMap;
  }

  List<Widget> getWidgets(BuildContext context, User? user,
      List<Message> _convos, List<Member> _users) {
    final List<Widget> list = <Widget>[];
    if (_convos != null && _users != null && user != null) {
      final Map<String, Member> userMap = getUserMap(_users);
      for (Message c in _convos) {
        if (c.userIds[0] == user.uid) {
          list.add(MessageListItem(
              user: user,
              peer: userMap[c.userIds[1]],
              lastMessage: c.lastMessage));
        } else {
          list.add(MessageListItem(
              user: user,
              peer: userMap[c.userIds[0]],
              lastMessage: c.lastMessage));
        }
      }
    }

    return list;
  }
}
