import 'package:cloud_firestore/cloud_firestore.dart';

class Member {
  String firstName;
  String lastName;
  String id;
  String email;
  String username;
  Timestamp? dateRegistered;

  Member(
      {this.firstName = '',
      this.lastName = '',
      this.id = '',
      this.email = '',
      this.username = 'Guest',
      this.dateRegistered});

  factory Member.fromMap(Map<String, dynamic>? userInfo) {
    if (userInfo == null) {
      return Member();
    }
    try {
      Member res = new Member(
        firstName: userInfo["firstName"],
        lastName: userInfo["lastName"],
        id: userInfo["id"],
        email: userInfo["email"],
        dateRegistered: userInfo["dateRegistered"],
        username: userInfo["username"],
      );
      print("resulting member is $res");
      return res;
    } catch (e) {
      print(e);
      print("ERROR: Error occurred during Member.fromMap");
      return Member(
          firstName: "ERROR",
          lastName: "ERROR",
          dateRegistered: Timestamp.now());
    }
  }

  @override
  String toString() {
    return "Member(id=$id , username=$username)";
  }
}
