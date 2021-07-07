import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_talk_money/models/member.dart';
import 'package:lets_talk_money/screens/home_builder.dart';
import 'package:lets_talk_money/services/database.dart';
import 'package:provider/provider.dart';

class ConversationProvider extends StatelessWidget {
  const ConversationProvider({
    // Key key,
    required this.user,
  });

  final User? user;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Convo>>.value(
        value: DatabaseService().streamConversations(user.id),
        child: ConversationDetailsProvider(user: user));
  }
}

class ConversationDetailsProvider extends StatelessWidget {
  const ConversationDetailsProvider({
    required this.user,
  });

  final User? user;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Member>>.value(
        value: DatabaseService().getUsersByList(
            getUserIds(Provider.of<List<Convo>>(context))),
        child: HomeBuilder());
  }

  List<String> getUserIds(List<Convo> _convos) {
    final List<String> users = <String>[];
    if (_convos != null) {
      for (Convo c in _convos) {
        c.userIds[0] != (user?.uid ?? '')
            ? users.add(c.userIds[0])
            : users.add(c.userIds[1]);
      }
    }
    return users;
  }
}
