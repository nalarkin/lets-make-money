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
    final addMessageButton = find.byValueKey('addMessageButton');
    final homeButton = find.byValueKey('homeButton');
    final messageInputField = find.byValueKey('messageInputField');
    final sendMessageButton = find.byValueKey('sendMessageButton');
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

    test('Click on profile button', () async {
      await driver.tap(profileButton);
    });
    test('Open user directory', () async {
      await driver.tap(addMessageButton);
      await driver.waitFor(find.text("Mike"));
      await driver.tap(find.text("Mike"));
    });
    test('Find and tap of on chat input box', () async {
      await driver.waitFor(messageInputField);
      await driver.tap(messageInputField);
    });

    test('Check that text input works properly', () async {
      await driver.enterText("Hello World!");
      await driver.waitFor(find.text("Hello World!"));
      // await driver.enterText('World!'); // enter another piece of text
      // await driver
      //     .waitFor(find.text('Hello World!World!')); // verify new text appears
    });
    test('Send message', () async {
      await driver.tap(sendMessageButton);
    });
    test('Confirm message contents were sent', () async {
      await driver.waitFor(find.text("Hello World!"));
    });
    test('Go back a page', () async {
      await driver.tap(PageBack());
    });

     test('Appbar title has Guest', () async {
      // Use the `driver.getText` method to verify the counter starts at 0.
      // expect(await driver.getText(counterTextFinder), "0");
      expect(await driver.getText(appbarFinder), "Guest");
    });


    test('Click on profile button', () async {
      await driver.tap(profileButton);
    });

    test('Click on profile button', () async {
      await driver.waitFor(find.by);
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
