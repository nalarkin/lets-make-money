import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lets_talk_money/services/auth.dart';
import 'package:lets_talk_money/services/database.dart';
import 'package:lets_talk_money/utils/widgets.dart';

void main() {
  // group("Sign in tests", () {
  //   test("User should anonymously sign in", () async {
  //     await Firebase.initializeApp();
  //     AuthService _auth = AuthService();
  //     User? firebaseUser = await _auth.firstLogin();
  //     expect(firebaseUser  != null, true);
  //   });
  // });

  // testWidgets("My button has text", (WidgetTester tester) async {
  //   await tester.pumpWidget(StyledButton(text: "T", onPressed: () => null));
  //   final titleFinder = find.text("T");
  //   expect(titleFinder, findsOneWidget);
  // });

  // testWidgets("My app bar has title", (WidgetTester tester) async {
  //   await tester.pumpWidget(myAppbar("testing"));
  //   final titleFinder = find.text("testing");
  //   expect(titleFinder, findsOneWidget);
  // });
}
