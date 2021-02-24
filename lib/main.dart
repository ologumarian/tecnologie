import 'package:documentive/models/project.dart';
import 'package:documentive/providers/auth_provider.dart';
import 'package:documentive/providers/documents.dart';
import 'package:documentive/providers/projects.dart';
import 'package:documentive/screens/project_screen.dart';
import 'package:documentive/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import './screens/drawer_screen.dart';
import './screens/home_screen.dart';
import './screens/auth_screen.dart';
import './screens/new_project_screen.dart';
//import './screens/splash_screen.dart';

//import './screens/auth_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //NUOVA CONFIG FIREBASE #4
  await Firebase.initializeApp(); //Inizializza app collegata a Firbase

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    // status bar color
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark));
    //nasconde la status bar
    SystemChrome.setEnabledSystemUIOverlays([]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Documents(),
        ),
        ChangeNotifierProvider(
          create: (_) => Projects(list: [], user: ''),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),

        //Il proxy provider effettua la DEPENDENCY INJECTION
        ChangeNotifierProxyProvider<AuthProvider, Projects>(
          //importante passare il contesto e inizializzare con create
          create: (ctx) => Projects(list: [], user: ''),
          update: (ctx, auth, previousProjects) => Projects(
            list: previousProjects.items.isEmpty ? [] : previousProjects.items,
            user: auth.username,
          ),
        ),
      ],
      child: FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  'Errore nel caricamneto dell\'app. Verifica la connessione a internet e riprova.'),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              theme: ThemeData(
                primarySwatch: Colors.blueGrey,
                accentColor: Colors.red[800],
                bottomAppBarColor: Colors.red[800], //per drawer
                textTheme: TextTheme(
                  bodyText1: TextStyle(color: Colors.grey[100]),
                ),
                backgroundColor: Colors.white,
              ),
              home: StreamBuilder(
                stream:
                    FirebaseAuth.instance.idTokenChanges(), //Listener sul Token
                builder: (ctx, userSnapshot) {
                  if (userSnapshot.hasData) {
                    return HomePage(); //Se il Token è valido viene visualizzata la HomePage
                  } else {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return SplashScreen();
                    } else {
                      return AuthScreen(); //Se il Token non esiste o non è valido viene caricato lo AuthScreen
                    }
                  }
                },
              ),
              routes: {
                '/project-details': (context) => ProjectScreen(),
                '/new-project': (context) => NewProjectScreen(),
              },
            );
          }
          // Otherwise, show something whilst waiting for initialization to complete
          else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
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
  // //NUOVA CONFIG FIREBASE #3
  // @override
  // void initState() {
  //   super.initState();
  //   Firebase.initializeApp().whenComplete(() {
  //     print("completed");
  //     setState(() {});
  //   });
  // }

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
