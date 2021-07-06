import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lets_talk_money/services.dart/auth.dart';
import 'package:lets_talk_money/services.dart/database.dart';
import 'package:lets_talk_money/utils/widgets.dart';

void main() {
  AuthService _auth = AuthService();

  test("User should anonymously sign in", () async {
    User? firebaseUser = await _auth.firstLogin();
    expect(firebaseUser != null, true);
  });

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
