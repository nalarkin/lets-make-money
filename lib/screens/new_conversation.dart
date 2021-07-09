import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_talk_money/models/member.dart';
import 'package:lets_talk_money/screens/chat_screen.dart';
import 'package:lets_talk_money/services/database.dart';
import 'package:lets_talk_money/utils/helper.dart';
import 'package:lets_talk_money/utils/widgets.dart';
import 'package:provider/provider.dart';

class NewConversation extends StatelessWidget {
  static final String routeName = '/new_conversation';
  @override
  Widget build(BuildContext context) {
    DatabaseService _db = Provider.of<DatabaseService>(context);

    User? currUser = Provider.of<User?>(context);

    return Scaffold(
      appBar: customAppBar(context, "User Directory"),
      body: StreamBuilder<List<Member>>(
        stream: _db.streamMembers,
        builder: (BuildContext context, AsyncSnapshot<List<Member>> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingCircle();
          }
          List<Member>? _messageList = snapshot.data;
          return new ListView.builder(
              reverse: true,
              shrinkWrap: true,
              padding: EdgeInsets.all(10.0),
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) => buildItem(
                  context, _messageList?[index] ?? Member(), currUser));
        },
      ),
    );
  }
}

Widget buildItem(context, Member currMember, User? currUser) {
  return Container(
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.face),
            onTap: () {
              String generatedConvoID = HelperFunctions.getConvoID(
                  currUser?.uid ?? '', currMember.id);
              print("CONVO Member $currMember currUser $currUser");
              print("generated CONVOID is $generatedConvoID");
              Navigator.pushNamed(context, ChatScreen.routeName,
                  arguments: ChatScreen(
                      convoID: generatedConvoID,
                      currReceiver: currMember.id,
                      currSender: currUser?.uid ?? '',
                      currReceiverUsername: currMember.username));
            },
            title: Text(currMember.username,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: Colors.black,
                    )),
          ),
          Divider(
            height: 20,
            color: Colors.black,
          )
        ],
      ));
}
