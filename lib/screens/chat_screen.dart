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
  ChatScreen(
      {this.convoID = '',
      this.currSender = '',
      this.currReceiver = '',
      this.currReceiverUsername = ''});
  String convoID;
  String currSender;
  String currReceiver;
  String currReceiverUsername;
  // late Member? currRecipient;
  // User? currUser;
  // String currSender;
  // User? currSender;
  // Member? currReceiver;
  // String currReceiver;

  @override
  _ChatScreenState createState() => _ChatScreenState(
      convoID: convoID,
      currSender: currSender,
      currReceiver: currReceiver,
      currReceiverUsername: currReceiverUsername);
}

class _ChatScreenState extends State<ChatScreen> {
  // final myController = TextEditingController();
  // _ChatScreenState();
  _ChatScreenState(
      {required this.convoID,
      required this.currReceiver,
      required this.currSender,
      required this.currReceiverUsername});
  String convoID;
  String currReceiver;
  String currSender;
  String currReceiverUsername;
  final ScrollController listScrollController = ScrollController();
  final TextEditingController myController = TextEditingController();

  // User? currSender;
  // Member? currReceiver;
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
    this.currReceiverUsername = args.currReceiverUsername;

    print("CONVOID IS : $convoID");
    return Scaffold(
      appBar: customAppBar(context, "$currReceiverUsername"),
      body: Stack(
          // fit: StackFit.expand,
          // alignment: Alignment.topCenter,
          children: <Widget>[
            //   Column(
            //     // mainAxisAlignment: MainAxisAlignment.start,
            //     children: <Widget>[
            // Flexible(
            // child: buildMessageList(),
            // Expanded(
            //   child: buildMessageList(),
            // ),
            buildMessageList(),

            // Expanded(
            //   child: Container(),
            // ),
            // ),
            // buildInput(context, myController),
            //   ],
            // ),
            Align(
              alignment: Alignment.bottomLeft,
              child: buildInput(context, myController),
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
          // controller: listScrollController,
          itemBuilder: (context, index) =>
              buildItem(context, _messageList?[index] ?? MessageCard()),
        );
      },
    );
  }

  Widget buildItem(context, MessageCard currCard) {
    User? currUser = Provider.of<User?>(context);

    // User? currUser = Provider.of<User?>(context);
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
                  // color: kSelfMessageTileColor,
                  color: Theme.of(context).primaryColor.withOpacity(0.4),
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
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
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

  Widget buildInput(BuildContext context, TextEditingController myController) {
    // Member newestMember = Provider.of<Member>(context);
    User? currUser = Provider.of<User?>(context);
    List<String> convoIDs = convoID.split('_');
    String receiverID =
        (convoIDs[0] != currUser?.uid) ? convoIDs[0] : convoIDs[1];
    DatabaseService _db = Provider.of<DatabaseService>(context);
    return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: Container(
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.black),
                        maxLines: 5,
                        controller: myController,
                        decoration: InputDecoration.collapsed(
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          // filled: true,
                          hintText: 'Type your message...',
                          // border: OutlineInputBorder(
                          //   borderSide:
                          //       BorderSide(color: Colors.black, width: 2.0),
                          // )
                        ),
                      )),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  icon: Icon(
                    Icons.send,
                    size: 25,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () async {
                    String msgContent = myController.text;
                    myController.clear();
                    MessageCard mc = MessageCard(
                      idFrom: currUser?.uid ?? '',
                      idTo: receiverID,
                      read: false,
                      content: msgContent.trim(),
                      timestamp: Timestamp.now(),
                    );
                    await _db.createMessageInDatabase(mc);
                    // listScrollController.animateTo(0.0,
                    //     duration: Duration(milliseconds: 300),
                    //     curve: Curves.easeOut);
                    print("Added $mc to Firestore.");
                    // myController.clear();
                  },
                ),
              ),
            ],
          ),
        ),
        width: double.infinity,
        height: 100.0);
  }

  // Future sendMessage() {

  // }

}
