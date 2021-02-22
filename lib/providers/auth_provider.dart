import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider with ChangeNotifier {
  String _uid;
  String _username;

  AuthProvider() {
    print('fetchAndSetUsername CONSTRUCTOR CALL');
    fetchAndSetUsername();
  }

  String get username {
    return _username;
  }

  Future<void> fetchAndSetUsername() async {
    //fetch da Firebase Auth dell'email
    await FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user != null) _uid = user.uid;
    });
    //fetch del nome utente da Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        _username = documentSnapshot.data()['username'];
        print('Document data: ${documentSnapshot.data()}');
      } else {
        print('Document does not exist on the database');
      }
    });
    notifyListeners();
    print('fetchAndSetUsername FX CALL');
  }

  Future<void> fetchAndSetUsernameOnLogin(String userId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        _username = documentSnapshot.data()['username'];
        print('Document data: ${documentSnapshot.data()}');
      } else {
        print('Document does not exist on the database');
      }
    });
    notifyListeners();
    print('fetchAndSetUsernameON_LOGIN FUNCTION CALL');
  }

  void logOut() {
    _uid = null;
    _username = null;
    //Distrugge il tocken e salta la condizione dello StreamBuilder nel main
    FirebaseAuth.instance.signOut();
  }
}
