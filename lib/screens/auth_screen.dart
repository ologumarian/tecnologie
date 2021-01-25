import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth
      .instance; //Crea in automatico un'istanza per l'autenticazione con Firebase
  var _isLoading = false;

  //FUNZIONE ASYNC: Restituisce un Future sul codice in await (le due funzioni richiamate su _auth)
  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult; //Era il vecchio AuthResult

    try {
      setState(() {
        _isLoading = true; //triggera la rotellina di caricamento
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user.uid)
          .set({
        'username': username,
        'email': email,
      });
    } on PlatformException catch (err) {
      var message = 'Qualcosa non va, prova a controllare le tue credenziali!';

      if (err.message != null) {
        message = err.message;
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).bottomAppBarColor,
      body: AuthForm(
        _submitAuthForm, //Passo il puntatore della funzione al widget AuthForm
        _isLoading,
      ),
    );
  }
}
