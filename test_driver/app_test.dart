// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('LetsMakeMoney App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final appbarFinder = find.byValueKey('appbar');
    // final appbarTextFinder = find.byValueKey('appbar');
    final drawerFinder = find.byValueKey('drawer');
    final drawerProfleFinder = find.byValueKey('drawerProfileButton');
    final profileButton = find.byValueKey('profileButton');
              // const Key("addMessageButton"),
              // key: const Key("homeButton"),




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
      expect(await driver.getText(appbarFinder), "Guest");
    });

    test('Drawer is visible', () async {
      // expect(await driver.get(drawerFinder),
      // await driver.tap(driver.sendCommand(command));
      // driver.waitFor(drawerFinder);
      await driver.tap(profileButton);
      await Future.delayed(Duration(seconds: 5));
      // expect(await driver.getText(drawerProfleFinder), "Profile");

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
