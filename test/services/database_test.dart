import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lets_talk_money/services.dart/database.dart';
import 'package:lets_talk_money/utils/widgets.dart';

void main() {
  DatabaseService db = DatabaseService();

  test("User should anonymously sign in", () async {
    

  });
  testWidgets("My button has text", (WidgetTester tester) async {
    await tester.pumpWidget(StyledButton(text: "T", onPressed: () => null));
    final titleFinder = find.text("T");
    expect(titleFinder, findsOneWidget);
  });

  testWidgets("My app bar has title", (WidgetTester tester) async {
    await tester.pumpWidget(myAppbar("testing"));
    final titleFinder = find.text("testing");
    expect(titleFinder, findsOneWidget);
  });
}
