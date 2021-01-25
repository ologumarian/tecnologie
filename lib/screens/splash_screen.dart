import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Image.asset('assets/images/large_documentive.png'),
          height: 100,
        ),
      ),
    );
  }
}
