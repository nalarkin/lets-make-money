// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:lets_talk_money/main.dart';

// void main() {
//   group('Testing App Performance Tests', () {
//     final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
//         as IntegrationTestWidgetsFlutterBinding;

//     binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
//     testWidgets("Load Home Page", (tester) async {
//       await tester.pumpWidget(AppToInitializeFirebase());
//       expect(find.text("Guest"), findsWidgets);
//     });
//   });
// }

// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Counter App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final appbarFinder = find.byValueKey('appbar');
    // final buttonFinder = find.byValueKey('increment');

    late FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      driver.close();
    });

    test('starts at 0', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      // expect(await driver.getText(counterTextFinder), "0");
      expect(await driver.getText(appbarFinder), "Guest");
    });

    // test('increments the counter', () async {
    //   // First, tap the button.
    //   await driver.tap(buttonFinder);

    //   // Then, verify the counter text is incremented by 1.
    //   expect(await driver.getText(counterTextFinder), "1");
    // });

    // test('increments the counter during animation', () async {
    //   await driver.runUnsynchronized(() async {
    //     // First, tap the button.
    //     await driver.tap(buttonFinder);

    //     // Then, verify the counter text is incremented by 1.
    //     expect(await driver.getText(counterTextFinder), "1");
    //   });
    // });
  });
}
