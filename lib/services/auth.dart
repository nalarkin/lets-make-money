import 'package:firebase_auth/firebase_auth.dart';
import 'package:lets_talk_money/services/database.dart';

class AuthService {
  DatabaseService _db = DatabaseService();
  FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get currentUser => _auth.userChanges();

  User? get firebaseUser => _auth.currentUser;

  Future<User?> firstLogin() async {
    User? currUser = _auth.currentUser;
    if (currUser != null) {
      return currUser;
    }

    User? newUser = await signInAnon();
    return newUser;
  }

  Future<bool> createUsernameDuringRegistration(
      User? user, String firstName, String lastName) async {
    try {
      String newUsername = firstName.trim() + '-' + lastName.trim();
      const int maxLenUsername = 18;
      if (newUsername.length > maxLenUsername) {
        print(
            "WARNING: username is longer than max allowed. Cutting off extra.");
        newUsername = newUsername.substring(0, maxLenUsername + 1);
      }

      await user?.updateDisplayName(newUsername);
      user?.reload();
      User? updatedUser = _auth.currentUser;
      print("username is updated to ${updatedUser?.displayName}");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<User?> signInAnon() async {
    print('trying to sign in anonymously');
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? currUser = result.user;
      await currUser?.updateDisplayName("Guest");

      User? updatedUser = _auth.currentUser;
      await _db.createUserInDatabase(updatedUser);
      print("signed in anonymously with user: $currUser");
      return updatedUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
