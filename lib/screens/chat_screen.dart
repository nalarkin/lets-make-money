import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lets_talk_money/services/database.dart';
import 'package:lets_talk_money/utils/widgets.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/chat_screen';
  // const ChatScreen({ Key? key }) : super(key: key);
  ChatScreen({required this.convoID});
  String convoID;

  @override
  _ChatScreenState createState() => _ChatScreenState(convoID: convoID);
}

class _ChatScreenState extends State<ChatScreen> {
  final myController = TextEditingController();
  // _ChatScreenState();
  _ChatScreenState({required this.convoID});
  String convoID;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar("Games Room"),
      body: Stack(children: <Widget>[
        Column(
          children: <Widget>[
            Flexible(
              child: buildMessageList(context),
            ),
            // buildInput(context, myController),
          ],
        )
      ]),
    );
  }

  Widget buildMessageList(
    BuildContext context,
  ) {
    DatabaseService db = Provider.of<DatabaseService>(context);
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('messages')
          .doc(convoID)
          .collection(convoID)
          .limit(20)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<List<MessageCard>> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingCircle();
        }
        List<MessageCard>? _messageList = snapshot.data;
        return new ListView.builder(
          reverse: true,
          shrinkWrap: true,
          padding: EdgeInsets.all(10.0),
          itemCount: snapshot.data?.length,
          itemBuilder: (context, index) => buildItem(context,
              _messageList?[index] ?? MessageCard(date: DateTime.now())),
        );
      },
    );
  }
}
