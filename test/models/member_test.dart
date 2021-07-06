import 'package:flutter_test/flutter_test.dart';
import 'package:lets_talk_money/models/Member.dart';

void main() {
  group('Testing Member class', () {
    Map<String, String> memberInfo = {
      "firstName": "mike",
      "lastName": "test",
      "id": '93939838xiexiufu839287ULNYT',
      "email": "tEst@gmail.com",
    };
    Member member1 = Member();
    test('An empty member should be a guest', () {
      var name = "Guest";

      expect(member1.username == name, true);
    });
  });
}
