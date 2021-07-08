import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lets_talk_money/models/member.dart';
import 'package:lets_talk_money/models/message_card.dart';
import 'package:lets_talk_money/services/database.dart';
import 'package:lets_talk_money/styles/colors.dart';
import 'package:lets_talk_money/utils/widgets.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/chat_screen';
  // const ChatScreen({ Key? key }) : super(key: key);
  ChatScreen({this.convoID = '', this.currSender, this.currReceiver});
  String convoID;
  // late Member? currRecipient;
  // User? currUser;
  // String currSender;
  User? currSender;
  Member? currReceiver;
  // String currReceiver;

  @override
  _ChatScreenState createState() => _ChatScreenState(
      convoID: convoID, currSender: currSender, currReceiver: currReceiver);
}

class _ChatScreenState extends State<ChatScreen> {
  final myController = TextEditingController();
  // _ChatScreenState();
  _ChatScreenState(
      {required this.convoID,
      required this.currReceiver,
      required this.currSender});
  String convoID;
  
  User? currSender;
  Member? currReceiver;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ChatScreen;
    print(
        "ARGS ARE HERE: args convoID ${args.convoID} currSender: ${args.currSender} receiver: ${args.currReceiver}");
    this.convoID = args.convoID;
    this.currSender = args.currSender;
    this.currReceiver = args.currReceiver;

    print("CONVOID IS : $convoID");
    return Scaffold(
      appBar: myAppbar("${currReceiver?.username}"),
      body: Stack(
          // fit: StackFit.expand,
          // alignment: Alignment.topCenter,
          children: <Widget>[
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Flexible(
                // child: buildMessageList(),
                buildMessageList(),
                // Expanded(
                //   child: Container(),
                // ),
                // ),
                // buildInput(context, myController),
              ],
            )
          ]),
    );
  }

  Widget buildMessageList() {
    DatabaseService db = Provider.of<DatabaseService>(context);
    return StreamBuilder<List<MessageCard>>(
      stream: FirebaseFirestore.instance
          .collection('messages')
          .doc(convoID)
          .collection(convoID)
          .limit(20)
          .snapshots()
          .map(db.convertToMessageList),
      builder:
          (BuildContext context, AsyncSnapshot<List<MessageCard>> snapshot) {
        if (snapshot.hasError) {
          // print(snapshot.error);
          return Text('Something went wrong. Error ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingCircle();
        }
        List<MessageCard>? _messageList = snapshot.data;

        return new ListView.builder(
          // reverse: true,
          shrinkWrap: true,
          padding: EdgeInsets.all(10.0),
          itemCount: snapshot.data?.length,
          itemBuilder: (context, index) =>
              buildItem(context, _messageList?[index] ?? MessageCard()),
        );
      },
    );
  }

  Widget buildItem(context, MessageCard currCard) {
    User? currUser = Provider.of<User?>(context);
    String timePosted = DateFormat.yMd()
        .add_jm()
        .format(currCard.timestamp?.toDate().toLocal() ?? DateTime.now());
    if (currCard.idFrom == (currUser?.uid ?? '')) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Bubble(
                  color: kSelfMessageTileColor,
                  elevation: 0,
                  padding: const BubbleEdges.fromLTRB(10, 4, 10, 4),
                  nip: BubbleNip.rightTop,
                  child: Column(
                    children: [
                      Row(
                          // children: [
                          //   Text(
                          //     "posted by: ${currCard.username}",
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .overline
                          //         ?.copyWith(color: kMessageUsernameAndDateColor),
                          //   ),
                          //   Expanded(
                          //     child: Container(),
                          //   ),
                          // ],
                          ),
                      Text(currCard.content,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: kMessageContentColor)),
                      Row(
                        children: [
                          Expanded(child: Container()),
                          Text(
                            "posted on: $timePosted",
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .overline
                                ?.copyWith(color: kMessageUsernameAndDateColor),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          )
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              width: 300.0,
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Bubble(
                  color: kMessageTileColor,
                  elevation: 0,
                  padding: const BubbleEdges.fromLTRB(10, 4, 10, 4),
                  nip: BubbleNip.leftTop,
                  child: Column(
                    children: [
                      // Row(
                      //   children: [
                      //     Text(
                      //       "posted by: ${currCard.author}",
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .overline
                      //           ?.copyWith(color: kMessageUsernameAndDateColor),
                      //     ),
                      //     Expanded(
                      //       child: Container(),
                      //     ),
                      //   ],
                      // ),
                      Text(currCard.content,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: kMessageContentColor)),
                      Row(
                        children: [
                          Expanded(child: Container()),
                          Text(
                            "posted on: $timePosted",
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .overline
                                ?.copyWith(color: kMessageUsernameAndDateColor),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          )
        ],
      );
    }
  }

  // Future sendMessage() {

  // }

}
