import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/drawer_screen.dart';
import './screens/home_screen.dart';
import './screens/auth_screen.dart';
import './screens/splash_screen.dart';

//import './screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //NUOVA CONFIG FIREBASE #4
  await Firebase.initializeApp(); //Inizializza app collegata a Firbase

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark, // status bar color
    ));
    SystemChrome.setEnabledSystemUIOverlays([]); //nasconde la status bar

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.red[800],
        bottomAppBarColor: Colors.red[800], //per drawer
        backgroundColor: Colors.white,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.idTokenChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return HomePage();
          }
          return AuthScreen();
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //NUOVA CONFIG FIREBASE #3
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          HomeScreen(),
        ],
      ),
    );
  }
}
