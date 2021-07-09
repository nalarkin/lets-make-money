import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('LetsMakeMoney App', () {
    final appbarFinder = find.byValueKey('appbar');

    final profileButton = find.byValueKey('profileButton');
    final addMessageButton = find.byValueKey('addMessageButton');
    final homeButton = find.byValueKey('homeButton');
    final messageInputField = find.byValueKey('messageInputField');
    final sendMessageButton = find.byValueKey('sendMessageButton');
    final profileUsername = find.byValueKey('profileUsername');

    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      driver.close();
    });

    test('Appbar title has Guest', () async {
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

    test('Click on profile button', () async {
      await driver.tap(profileButton);
    });

    test('Click on profile button', () async {
      await driver.waitFor(profileUsername);
      expect(await driver.getText(profileUsername), "Guest");
    });
  });
}
