import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String _username;

  AuthProvider() {
    print('fetchAndSetUsername CONSTRUCTOR CALL');
    fetchAndSetUsername();
  }

  Future<void> fetchAndSetUsername() async {
    await FirebaseAuth.instance.authStateChanges().listen((User user) {
      _username = user.email;
    });
    notifyListeners();
    // print('fetchAndSetUsername FX CALL');
  }

  String get username {
    return _username;
  }
}
