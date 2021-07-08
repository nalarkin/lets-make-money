import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lets_talk_money/screens/profile.dart';
import 'package:lets_talk_money/services/auth.dart';
import 'package:provider/provider.dart';

// Widget createProfileScreen() async {
//   await Firebase.initializeApp();

//   MultiProvider(
//       providers: [
//         StreamProvider<User?>.value(
//           value: _auth.currentUser,
//           initialData: null,
//         ),
//       ],
//       builder: (context, widget) {
//         MaterialApp(
//           title: 'Nathan',
//           theme: ThemeData(primarySwatch: Colors.blueGrey),
//           home: Profile(),

//           // To navigate to another page enter type the command:
//           // Navigator.pushNamed(context, <ClassWithRouteName>.routeName);
//           // example: Navigator.pushNamed(context, Register.routeName);
//           routes: <String, WidgetBuilder>{
//             Profile.routeName: (context) => Profile(),
//           }
//           );
//           },);

//       child: MaterialApp(
//           title: 'Nathan',
//           theme: ThemeData(primarySwatch: Colors.blueGrey),
//           home: Profile(),

//           // To navigate to another page enter type the command:
//           // Navigator.pushNamed(context, <ClassWithRouteName>.routeName);
//           // example: Navigator.pushNamed(context, Register.routeName);
//           routes: <String, WidgetBuilder>{
//             Profile.routeName: (context) => Profile(),
//           }));
// }
// Widget testAuth() {

// }

// class testAuth extends StatelessWidget {
//   const testAuth({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     User? currUser = Provider.of<User?>(context);
//     print("CURRENT MOCK USER: $currUser");
//     return Text(currUser?.displayName ?? '');
//   }
// }

// class CreateProfilePage extends StatelessWidget {
//   const CreateProfilePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     User? currUser = Provider.of<User?>(context);
//     print("CURRENT MOCK USER: $currUser");
//     return Profile();
//   }
// }

// class ProfileTester {
//   ProfileTester({required this.firebase});

//   Future setUp() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     await Firebase.initializeApp();
//   }

//   Widget launch() {
//     return
//   }

//   FirebaseFirestore firebase;
// }

const MSG_COLLECTION = 'messages';
void main() {
  group("Testing Profile Page", () {
    // testWidgets("Testing Initial Load", (tester) async {
    //   await tester.pumpWidget(createProfileScreen());
    //   expect(find.text("Profile"), findsOneWidget);
    // });

    // fire_auth.authStateChanges();
    // fire_auth.signInAnonymously()
    // print(fire_auth.currentUser)
    // print("USER IN MAIN ${fire_auth.currentUser}");

    // AuthService _auth = AuthService();

    testWidgets("Testing Initial Load", (tester) async {
      final firestore = FakeFirebaseFirestore();

      // await firestore.collection(path)
      final user = MockUser(
        isAnonymous: false,
        uid: "SOME_LoNG_ID_69",
        email: "abc@gmail.com",
        displayName: "MickeyMouse",
      );
      // print("USER IN MAIN $user");
      final fire_auth = MockFirebaseAuth(mockUser: user, signedIn: true);
      // WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      print("initialized app");
      await tester.pumpWidget(MultiProvider(
        providers: [
          StreamProvider<User?>.value(
            value: fire_auth.authStateChanges(),
            initialData: null,
          ),
        ],
        // child: MaterialApp(home: testAuth()),
        child: MaterialApp(home: Profile(firestore)),
        // child: Builder(
        //   builder: (context) => ,
        //   // builder: (_) => Profile(),
        // )));
        // expect(find.text("Profile"), findsOneWidget);
      ));
      await tester.idle();
      await tester.pump();
      expect(find.text("MickeyMouse"), findsOneWidget);
      expect(find.text("Profile"), findsOneWidget);
    });
  });
}
