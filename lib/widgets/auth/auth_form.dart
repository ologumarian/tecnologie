import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);

  final bool isLoading;
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  //variabili login ...
  final _formKey = GlobalKey<FormState>();

  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState
        .validate(); //Triggera i validator del form di login/signup
    FocusScope.of(context)
        .unfocus(); //Toglie il focus dalle TextFormField nascondendo la tastiera

    if (isValid) {
      _formKey.currentState.save(); //triggera tutti gli onSaved dei FormField
      //Passo i dati alla funzione che provvederà a inviare i dati a Firebase
      widget.submitFn(
        _userEmail.trim(), //trim() rimuove gli spazi bianchi
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
        context,
      );
    }
  }

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
            key: _formKey,
            child: Column(
              children: [
                Container(
                  child: Image.asset('assets/images/large_documentive.png'),
                  height: 100,
                ),
                SizedBox(height: 25),
                TextFormField(
                  key: ValueKey('email'),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Inserisci un indirizzo email valido';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _userEmail = value;
                  },
                ),
                if (!_isLogin)
                  TextFormField(
                    key: ValueKey('nome'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                    ),
                    validator: (value) {
                      if (value.length < 4) {
                        return 'Inserisci un nome di almeno 4 caratteri';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userName = value;
                    },
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty || value.length < 7) {
                      return 'La password deve essere lunga almeno 8 caratteri';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _userPassword = value;
                  },
                ),
                SizedBox(height: 15),
                //Se c'è il caricamento viene mostrata la rotellina
                if (widget.isLoading) CircularProgressIndicator(),
                //Non mostro il pulsante se c'è un caricamento
                if (!widget.isLoading)
                  ElevatedButton(
                    child: Text(_isLogin ? 'Login' : 'Registrati'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    onPressed: _trySubmit,
                  ),
                //Non mostro il pulsante se c'è un caricamento
                if (!widget.isLoading)
                  TextButton(
                    child: Text(_isLogin
                        ? 'Crea un nuovo account'
                        : 'Ho già un account'),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
