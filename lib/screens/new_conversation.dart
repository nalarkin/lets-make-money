import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_talk_money/models/member.dart';
import 'package:lets_talk_money/screens/build_input.dart';
import 'package:lets_talk_money/screens/chat_screen.dart';
import 'package:lets_talk_money/services/database.dart';
import 'package:lets_talk_money/utils/helper.dart';
import 'package:lets_talk_money/utils/widgets.dart';
import 'package:provider/provider.dart';

class NewConversation extends StatelessWidget {
  // const NewConversation({Key? key}) : super(key: key);
  static final String routeName = '/new_conversation';
  @override
  Widget build(BuildContext context) {
    DatabaseService _db = Provider.of<DatabaseService>(context);
    List<Member> currMembers = Provider.of<List<Member>>(context);
    User? currUser = Provider.of<User?>(context);

    return Scaffold(
      appBar: myAppbar("User Directory"),
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
      // width: MediaQuery.of(context).size.width * 0.6,
      // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      // color: Theme.of(context).cardColor,
      color: Theme.of(context).cardColor,
      // margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            // tileColor: Colors.green,
            // tileColor: Theme.of(context).cardColor,
            leading: Icon(Icons.face),
            onTap: () => Navigator.pushNamed(context, ChatScreen.routeName,
                arguments: HelperFunctions.getConvoID(
                    currUser?.uid ?? '', currMember.id)),
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
      )
      // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      //   Icon(Icons.face),
      //   Text(currMember.username,
      //       style: Theme.of(context).textTheme.bodyText2?.copyWith(
      //             color: Colors.black,
      //           )),
      // ]),
      );
} 
  





// class NewConversation extends StatelessWidget {
//   const NewConversation(
//       {required this.uid, required this.contact, required this.convoID});
//   final String uid, convoID;
//   final Member contact;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//             automaticallyImplyLeading: true, title: Text(contact.username)),
//         body: ChatScreen(uid: uid, convoID: convoID, contact: contact));
//   }
// }

// class ChatScreen extends StatefulWidget {
//   const ChatScreen(
//       {required this.uid, required this.convoID, required this.contact});
//   final String uid, convoID;
//   final Member contact;

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   String uid = '';
//   String convoID = '';
//   Member contact = Member();
//   TextEditingController textEditingController = TextEditingController();
//   ScrollController listScrollController = ScrollController();


//   @override
//   void initState() {
//     super.initState();
//     uid = widget.uid;
//     convoID = widget.convoID;
//     contact = widget.contact;
//   }

//   Widget buildMessages() {
//     FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;
    
//     return Flexible(
//       child: StreamBuilder(
//         stream: _firestoreInstance
//             .collection('messages')
//             .doc(convoID)
//             .collection(convoID)
//             .orderBy('timestamp', descending: true)
//             .limit(20)
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasData) {
//             List<QueryDocumentSnapshot<Object?>> listMessage =
//                 snapshot.data?.docs ?? [];
//             return ListView.builder(
//               padding: const EdgeInsets.all(10.0),
//               itemBuilder: (BuildContext context, int index) =>
//                   buildItem(index, listMessage[index], convoID),
//               itemCount: listMessage.length,
//               reverse: true,
//               controller: listScrollController,
//             );
//           } else {
//             return Container();
//           }
//         },
//       ),
//     );
//   }

//   Widget buildItem(int index, DocumentSnapshot document, String convoID) {
//     if (!document['read'] && document['idTo'] == uid) {
//       DatabaseService().updateMessageRead(document, convoID);
//     }

//     if (document['idFrom'] == uid) {
//       // Right (my message)
//       return Row(
//         children: <Widget>[
//           // Text
//           Container(
//               margin: EdgeInsets.symmetric(vertical: 5),
//               child: Bubble(
//                   color: Colors.blueGrey,
//                   elevation: 0,
//                   padding: const BubbleEdges.all(10.0),
//                   nip: BubbleNip.rightTop,
//                   child: Text(document['content'],
//                       style: TextStyle(color: Colors.white))),
//               width: 200)
//         ],
//         mainAxisAlignment: MainAxisAlignment.end,
//       );
//     } else {
//       // Left (peer message)
//       return Container(
//         margin: EdgeInsets.symmetric(vertical: 5),
//         child: Column(
//           children: <Widget>[
//             Row(children: <Widget>[
//               Container(
//                 child: Bubble(
//                     color: Colors.white10,
//                     elevation: 0,
//                     padding: const BubbleEdges.all(10.0),
//                     nip: BubbleNip.leftTop,
//                     child: Text(document['content'],
//                         style: TextStyle(color: Colors.white))),
//                 width: 200.0,
//                 margin: const EdgeInsets.only(left: 10.0),
//               )
//             ])
//           ],
//           crossAxisAlignment: CrossAxisAlignment.start,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Stack(
//         children: <Widget>[
//           Column(
//             children: <Widget>[
//               buildMessages(),
//               buildInput(),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildInput() {
//   return Container(
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Row(
//           children: <Widget>[
//             // Edit text
//             Flexible(
//               child: Container(
//                 child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: TextField(
//                       autofocus: true,
//                       maxLines: 5,
//                       controller: textEditingController,
//                       decoration: const InputDecoration.collapsed(
//                         hintText: 'Type your message...',
//                       ),
//                     )),
//               ),
//             ),
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: IconButton(
//                 icon: Icon(Icons.send, size: 25),
//                 onPressed: () => onSendMessage(textEditingController.text),
//               ),
//             ),
//           ],
//         ),
//       ),
//       width: double.infinity,
//       height: 100.0);
// }

//   void onSendMessage(String content) {
//     if (content.trim() != '') {
//       textEditingController.clear();
//       content = content.trim();
//       sendMessage(convoID, uid, contact.id, content,
//           DateTime.now().millisecondsSinceEpoch.toString());
//       listScrollController.animateTo(0.0,
//           duration: Duration(milliseconds: 300), curve: Curves.easeOut);
//     }
//   }

//   static void sendMessage(
//     String convoID,
//     String id,
//     String pid,
//     String content,
//     String timestamp,
//   ) {
//     DocumentReference<Map<String, dynamic>> convoDoc =
//         FirebaseFirestore.instance.collection('messages').doc(convoID);

//     convoDoc.set(<String, dynamic>{
//       'lastMessage': <String, dynamic>{
//         'idFrom': id,
//         'idTo': pid,
//         'timestamp': timestamp,
//         'content': content,
//         'read': false
//       },
//       'users': <String>[id, pid]
//     }).then((dynamic success) {
//       final DocumentReference messageDoc = FirebaseFirestore.instance
//           .collection('messages')
//           .doc(convoID)
//           .collection(convoID)
//           .doc(timestamp);

//       FirebaseFirestore.instance
//           .runTransaction((Transaction transaction) async {
//         await transaction.set(
//           messageDoc,
//           <String, dynamic>{
//             'idFrom': id,
//             'idTo': pid,
//             'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
//             'content': content,
//             'read': false
//           },
//         );
//       });
//     });
//   }
// }
