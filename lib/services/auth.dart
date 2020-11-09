import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/services/database.dart';

import 'package:flutter/material.dart';
import 'package:firebase_flutter/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create use objcct based on firebaseuser
  Userdata _userFromFirebaseUser(User user) {
    return user != null ? Userdata(uid: user.uid) : null;
  }

  //auth chage user stream

  Stream<Userdata> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

//signin anon
  Future signuInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//signin email and pss
  Future signInWithEnailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//Register with email and pass
  Future registerWithEnailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      //creat a new document for the user with the uid
      await DatabaseService(uid: user.uid)
          .updateUserData('0', 'new member', 100);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//signout
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
