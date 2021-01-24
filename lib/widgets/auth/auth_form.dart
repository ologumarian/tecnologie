import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  //variabili login ...

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        margin: EdgeInsets.all(20),
        color: Colors.grey[100],
        elevation: 10,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
              child: Column(
            children: [
              Container(
                child: Image.asset('assets/images/large_documentive.png'),
                height: 100,
              ),
              SizedBox(height: 25),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              SizedBox(height: 15),
              ElevatedButton(
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                onPressed: () {},
              ),
              TextButton(
                child: Text('Registrati'),
                onPressed: () {},
              ),
            ],
          )),
        ),
      ),
    );
  }
}
