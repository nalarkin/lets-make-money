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
  group('LetsMakeMoney App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final appbarTextFinder = find.byValueKey('appbar');
    final drawerFinder = find.byValueKey('drawer');
    final drawerProfleFinder = find.byValueKey('drawerProfileButton');
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

    test('Appbar title has Guest', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      // expect(await driver.getText(counterTextFinder), "0");
      expect(await driver.getText(appbarTextFinder), "Guest");
    });

    test('Drawer is visible', () async {
      // expect(await driver.get(drawerFinder),
      await driver.tap(find.byValueKey(drawerFinder));
      expect(await driver.getText(drawerProfleFinder), "Profile");

      // (appbarTextFinder), "Guest");
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
