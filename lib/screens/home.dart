import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_talk_money/models/conversation.dart';
import 'package:lets_talk_money/models/member.dart';
import 'package:lets_talk_money/models/message_card.dart';
import 'package:lets_talk_money/screens/chat_screen.dart';
import 'package:lets_talk_money/screens/new_conversation.dart';
import 'package:lets_talk_money/services/auth.dart';
import 'package:lets_talk_money/services/database.dart';
import 'package:lets_talk_money/utils/helper.dart';
import 'package:lets_talk_money/utils/widgets.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  static const String routeName = "/home";
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? currUser = Provider.of<User?>(context);
    // AuthService _auth = AuthService();
    // print(currUser);

    return StreamProvider<List<Conversation>>.value(
        initialData: [],
        value: Provider.of<DatabaseService>(context)
            .streamConversations(currUser?.uid ?? ''),
        child: getUserList());
  }
}

class getUserList extends StatelessWidget {
  const getUserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? currUser = Provider.of<User?>(context);
    AuthService _auth = AuthService();
    List<Conversation> currConvos = Provider.of<List<Conversation>>(context);
    DatabaseService _db = Provider.of<DatabaseService>(context);
    return StreamProvider<List<String>>.value(
        value: _db.convertConversationsToMembers(currUser, currConvos),
        initialData: [],
        child: HomePageConversations());
  }
}

class HomePageConversations extends StatefulWidget {
  const HomePageConversations({Key? key}) : super(key: key);

  @override
  _HomePageConversationsState createState() => _HomePageConversationsState();
}

class _HomePageConversationsState extends State<HomePageConversations> {
  @override
  Widget build(BuildContext context) {
    User? currUser = Provider.of<User?>(context);
    AuthService _auth = AuthService();
    List<Conversation> currConvos = Provider.of<List<Conversation>>(context);
    List<String> currSenders = Provider.of<List<String>>(context);
    Map<String, Member> memberMap =
        HelperFunctions.getMemberMap(Provider.of<List<Member>>(context));
    if (currSenders.length != currConvos.length) {
      return LoadingCircle();
    }
    // assert(currSenders.length == currConvos.length);
    print(currUser);
    print("CURRENT CONVOS: $currConvos");
    return Scaffold(
      drawer: customDrawer(context),
      appBar: AppBar(
        title: Text(currUser?.displayName ?? ''),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => createDummyMessage(
                "oYwXPIfUFjfDyABGIgXkzdzsYkr2", "O9uAX7fwujV63IVJeWGG84TPxjv1"),
            icon: Icon(Icons.mail),
          ),
          IconButton(onPressed: _auth.signOut, icon: Icon(Icons.logout)),
          IconButton(
              // onPressed: () => createNewConvo(context),
              onPressed: () =>
                  Navigator.pushNamed(context, NewConversation.routeName),
              icon: Icon(
                Icons.add,
                size: 30,
              ))
        ],
      ),
      // body: Text("$currConvos"),
      body: ListView.builder(
        itemBuilder: (context, index) => buildConversationCard(context,
            currUser, currConvos[index], currSenders[index], memberMap),
        itemCount: currConvos.length,
      ),
    );
  }
}

Widget buildConversationCard(
    context,
    User? currUser,
    Conversation currConversation,
    String currSender,
    Map<String, Member> memberMap) {
  String currReceiverUsername =
      memberMap[currConversation.users[1]]?.username ?? '';
  if (currUser?.uid != currConversation.users[0]) {
    currReceiverUsername = memberMap[currConversation.users[0]]?.username ?? '';
  }
  // }

  return Card(
    // color: Theme.of(context).cardColor,
    // color: Colors.black,
    child: ListTile(
      // focusColor: Theme.of(context).cardColor,
      // tileColor: Theme.of(context).cardColor,
      tileColor: Theme.of(context).cardColor,
      onTap: () {
        Navigator.pushNamed(context, ChatScreen.routeName,
            arguments: ChatScreen(
                convoID: currConversation.id,
                currReceiver: "REMOVE IF YOU SEE",
                currSender: currUser?.uid ?? '',
                currReceiverUsername: currReceiverUsername));
      },
      leading: Text(currSender),
      title: Text(currConversation.lastMessage.content),
    ),
  );
}

Future createDummyMessage(String senderID, String receiverID) async {
  MessageCard msgCardToAdd = MessageCard(
      content: "dummy content",
      idFrom: senderID,
      idTo: receiverID,
      read: false,
      timestamp: Timestamp.now());
  DatabaseService db = DatabaseService();
  await db.createMessageInDatabase(msgCardToAdd);
  print("message creation complete");
}

// class Home extends StatelessWidget {
//   static const String routeName = "/home";
//   const Home({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     User? currUser = Provider.of<User?>(context);
//     AuthService _auth = AuthService();
//     print(currUser);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(currUser?.displayName ?? ''),
//         actions: [
//           IconButton(
//               // onPressed: () => createNewConvo(context),
//               onPressed: () => null,
//               icon: Icon(
//                 Icons.add,
//                 size: 30,
//               ))
//         ],
//       ),
//       body: Container(
//           child: Center(
//         child: Column(
//           children: [
//             Text("$currUser"),
//             MaterialButton(
//               onPressed: () async => await _auth.signOut(),
//               child: Text("Sign out"),
//             ),
//             MaterialButton(
//               onPressed: () async =>
//                   DatabaseService().createUserInDatabase(currUser),
//               child: Text("create user"),
//             )
//           ],
//         ),
//       )),
//     );
//   }
// }

// void createNewConvo(BuildContext context) {
//     Navigator.of(context).push<dynamic>(MaterialPageRoute<dynamic>(
//         builder: (BuildContext context) => NewMessageProvider()));
//   }

Future<void> printUser() async {
  AuthService _auth = AuthService();
  User? firebaseUser = await _auth.firstLogin();
  print(firebaseUser);
}
