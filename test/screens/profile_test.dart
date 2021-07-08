import 'package:firebase_auth/firebase_auth.dart';
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

void main() {
  group("Testing Profile Page", () {
    // testWidgets("Testing Initial Load", (tester) async {
    //   await tester.pumpWidget(createProfileScreen());
    //   expect(find.text("Profile"), findsOneWidget);
    // });

    AuthService _auth = AuthService();
    testWidgets("Testing Initial Load", (tester) async {
      FirebaseApp curr = await Firebase.initializeApp();
      await tester.pumpWidget(MultiProvider(
          providers: [
            StreamProvider<User?>.value(
              value: _auth.currentUser,
              initialData: null,
            ),
          ],
          child: Builder(
            builder: (_) => Profile(),
          )));
      expect(find.text("Profile"), findsOneWidget);
    });
  });
}
