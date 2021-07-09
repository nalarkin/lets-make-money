import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lets_talk_money/models/conversation.dart';
import 'package:lets_talk_money/models/member.dart';
import 'package:lets_talk_money/models/message_card.dart';
import 'package:lets_talk_money/screens/chat_screen.dart';
import 'package:lets_talk_money/screens/new_conversation.dart';
import 'package:lets_talk_money/services/auth.dart';
import 'package:lets_talk_money/services/convo_counter.dart';
import 'package:lets_talk_money/services/database.dart';
import 'package:lets_talk_money/utils/helper.dart';
import 'package:lets_talk_money/utils/widgets.dart';
import 'package:provider/provider.dart';
import 'package:lets_talk_money/utils/ad_helper.dart';

class Home extends StatelessWidget {
  static const String routeName = "/home";
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? currUser = Provider.of<User?>(context);
    // AuthService _auth = AuthService();
    // print(currUser);

    return (currUser == null)
        ? LoadingCircle()
        : StreamProvider<List<Conversation>>.value(
            initialData: [],
            value: Provider.of<DatabaseService>(context)
                .streamConversations(currUser.uid),
            child: getUserList());
  }
}

// Widget initializeAds() {
//   FutureBuilder(
//     future: _initGoogleMobileAds,
//     initialData: null,
//     builder: (BuildContext context, AsyncSnapshot snapshot) {
//       return ;
//     },
//   ),
// }

// Initialize Google Mobile Ads SDK
Future<InitializationStatus> _initGoogleMobileAds() {
  return MobileAds.instance.initialize();
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
      appBar: customAppBar(context, currUser?.displayName ?? ''),
      // body: Text("$currConvos"),
      body: FutureBuilder(
        future: _initGoogleMobileAds(),
        // initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return BuildConversations();
        },
      ),
    );
  }
}

class BuildConversations extends StatefulWidget {
  const BuildConversations({Key? key}) : super(key: key);

  @override
  _BuildConversationsState createState() => _BuildConversationsState();
}

class _BuildConversationsState extends State<BuildConversations> {
  late BannerAd _bannerAd;
  int convoSeen = 0;
  bool _isBannerAdReady = false;
  // TODO: Add _interstitialAd
  InterstitialAd? _interstitialAd;
  // TODO: Add _isInterstitialAdReady
  bool _isInterstitialAdReady = false;
  // TODO: Implement _loadInterstitialAd()
  void _loadInterstitialAd() {
    //  convoID: currConversation.id,
    //             currReceiver: "REMOVE IF YOU SEE",
    //             currSender: currUser?.uid ?? '',
    //             currReceiverUsername: currReceiverUsername
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this._interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              // Navigator.pop(context);
            },
          );

          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  // void onGameOver(int correctAnswers) {
  //   showDialog(
  //     context: _scaffoldKey.currentContext,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('Game over!'),
  //         content: Text('Score: $correctAnswers/5'),
  //         actions: [
  //           FlatButton(
  //             child: Text('close'.toUpperCase()),
  //             onPressed: () {
  //               // TODO: Display an Interstitial Ad
  //               if (_isInterstitialAdReady) {
  //                 _interstitialAd?.show();
  //               } else {
  //                 _moveToHome();
  //               }
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  void initState() {
    super.initState();

    // QuizManager.instance
    //   ..listener = this
    //   ..startGame();

    // COMPLETE: Initialize _bannerAd
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();

    // COMPLETE: Load a Rewarded Ad
    // _loadRewardedAd();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ConvoCount convoCounter = Provider.of<ConvoCount>(context);
    User? currUser = Provider.of<User?>(context);
    AuthService _auth = AuthService();
    List<Conversation> currConvos = Provider.of<List<Conversation>>(context);
    List<String> currSenders = Provider.of<List<String>>(context);
    Map<String, Member> memberMap =
        HelperFunctions.getMemberMap(Provider.of<List<Member>>(context));
    bool _showAd = false;
    print("currentCounter is ${convoCounter.count}");
    print("_showAd is ${_showAd}");

    // if (convoCounter.count > 2 && !_isInterstitialAdReady) {
    //   _loadInterstitialAd();
    //   // _showAd = true;
    //   // convoCounter.reset();
    // }
    // convoCounter.add();
    return SafeArea(
      child: Stack(
        children: [
          ListView.builder(
            itemBuilder: (context, index) => buildConversationCard(
                context,
                currUser,
                currConvos[index],
                currSenders[index],
                memberMap,
                convoCounter),
            itemCount: currConvos.length,
          ),
          if (_isBannerAdReady)
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: _bannerAd.size.width.toDouble(),
                height: _bannerAd.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildConversationCard(
      context,
      User? currUser,
      Conversation currConversation,
      String currSender,
      Map<String, Member> memberMap,
      ConvoCount convoCounter) {
    String currReceiverUsername =
        memberMap[currConversation.users[1]]?.username ?? '';
    if (currUser?.uid != currConversation.users[0]) {
      currReceiverUsername =
          memberMap[currConversation.users[0]]?.username ?? '';
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
          int currentCount = convoCounter.count;
          print("current count inside the card you clicked!");
          if (_isInterstitialAdReady) {
            _interstitialAd?.show();
            convoCounter.reset();
          } else if (currentCount > 2 && !_isInterstitialAdReady) {
            //  _interstitialAd?.show();
            _loadInterstitialAd();
          } else {
            print("CONVO MANIP. BEFORE ADDING ${convoCounter.count}");
            convoCounter.add();
            print("CONVO MANIP. AFTER ADDING ${convoCounter.count}");
          }
          // int currentCount = currentCounter.count;
          // currentCounter.add();
          // print("convoSeen CURRENT VALUE IS $currentCount");
          // if (convoSeen > 1 && !_isInterstitialAdReady) {
          //   _loadInterstitialAd();
          // } else if (_isBannerAdReady) {
          //   setState(() {
          //     convoSeen = 0;
          //   });
          //   _interstitialAd?.show();
          // } else {
          //   setState(() {
          //     convoSeen = convoSeen + 1;
          //   });
          // }

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
