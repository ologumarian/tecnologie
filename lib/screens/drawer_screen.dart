import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:documentive/providers/auth_provider.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../config/configuration.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final theme = true; //se false tema bianco

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: theme ? Theme.of(context).bottomAppBarColor : Colors.white,
        padding: EdgeInsets.only(
          left: 15,
          top: 44,
          bottom: 24,
          right: 200,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blueGrey[100],
                ),
                Container(
                    margin: EdgeInsets.only(top: 16, bottom: 50),
                    child: Consumer<AuthProvider>(
                      builder: (ctx, authData, child) {
                        print('BUILDER FX');
                        if (authData.username == null) {
                          print('BUILDER No Data');
                          return Text('data');
                        } else {
                          print('BUILDER Text');
                          return Text(
                            authData.username,
                            softWrap: true,
                            style: TextStyle(
                              color: theme ? Colors.grey[100] : Colors.black87,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                      },
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: drawerItems
                      .map((element) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  element['icon'],
                                  color:
                                      theme ? Colors.grey[100] : Colors.black87,
                                  size: 30,
                                ),
                                SizedBox(width: 10),
                                Text(element['title'],
                                    style: TextStyle(
                                      color: theme
                                          ? Colors.grey[100]
                                          : Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ))
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextButton(
                      child: Row(
                        children: [
                          Icon(Icons.exit_to_app,
                              color: theme ? Colors.grey[100] : Colors.black87),
                          SizedBox(width: 10),
                          Text(
                            'Log out',
                            style: TextStyle(
                              color: theme
                                  ? Theme.of(context).textTheme.bodyText1.color
                                  : Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        //LOGOUT DELL'UTENTE:
                        //Distrugge il tocken e salta la condizione dello StreamBuilder nel main
                        FirebaseAuth.instance.signOut();
                      },
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
