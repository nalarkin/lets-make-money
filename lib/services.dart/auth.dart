import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthService {
  // Member currentMember = Member();
  // DatabaseService _db = DatabaseService();
  FirebaseAuth _auth = FirebaseAuth.instance;
  // User? user;
  // AuthService();
  Stream<User?> get currentUser => _auth.userChanges();

  User? get firebaseUser => _auth.currentUser;

  Future<User?> firstLogin() async {
    User? currUser = _auth.currentUser;
    if (currUser != null) {
      return currUser;
    }

    // first time user
    User? newUser = await signInAnon();
    return newUser;
  }

  // Allows the app to grab up to date current user from anywhere in the app.
  // Access by useing "Provider.of<AuthService>(context, listen: false).getUser()"
  // Future<User?> getUser() async {
  //   try {
  //     final currUser = _auth.currentUser;

  //     if (currUser != null) {
  //       print('User signed in: ${currUser.email}');
  //     } else {
  //       print('No user signed in');
  //     }
  //     notifyListeners();
  //     return currUser;
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }

  // // used by futurebuilder to do an initial check if user is signed in/out
  // // happens when app first launches
  // Future<User?> firstLogin() async {
  //   try {
  //     final currUser = _auth.currentUser;

  //     if (currUser != null) {
  //       print('User signed in: ${currUser.email}');
  //       print('Creating Member Object');
  //       // get user info from DatabaseService
  //       Map<String, dynamic>? res =
  //           await _db.getUserInfoFromFirestore(currUser);
  //       print(res);
  //       if (res != null) {
  //         currentMember = Member.fromMap(res);
  //         // print("Created new member during sign in. $currentMember");
  //       }
  //     } else {
  //       print('No user signed in');
  //     }
  //     return currUser;
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }

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

  // anonymous sign in
  // update display name to 'Guest'
  Future<User?> signInAnon() async {
    print('trying to sign in anonymously');
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? currUser = result.user;
      await currUser?.updateDisplayName("Guest");
      // await currUser?.reload();
      User? updatedUser = _auth.currentUser;
      print("signed in anonymously with user: $currUser");
      return updatedUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      // notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
