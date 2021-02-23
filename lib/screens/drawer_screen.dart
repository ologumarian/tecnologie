import 'package:documentive/providers/auth_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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

        //AUTH PROVIDER CONSUMER!
        child: Consumer<AuthProvider>(
          builder: (context, authData, child) {
            print('DRAWER BUILD');
            if (mounted) {
              return Column(
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
                      ValueListenableBuilder(
                        valueListenable:
                            ValueNotifier<String>(authData.username),
                        builder: (context, String value, _) => Container(
                            margin: EdgeInsets.only(top: 16, bottom: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ciao,',
                                  style: TextStyle(
                                    color: theme
                                        ? Colors.grey[100]
                                        : Colors.black87,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  value == null ? 'Username' : value,
                                  key: UniqueKey(),
                                  softWrap: true,
                                  style: TextStyle(
                                    color: theme
                                        ? Colors.grey[100]
                                        : Colors.black87,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: drawerItems
                            .map((element) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        element['icon'],
                                        color: theme
                                            ? Colors.grey[100]
                                            : Colors.black87,
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
                                    color: theme
                                        ? Colors.grey[100]
                                        : Colors.black87),
                                SizedBox(width: 10),
                                Text(
                                  'Log out',
                                  style: TextStyle(
                                    color: theme
                                        ? Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .color
                                        : Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              authData.logOut();
                            },
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              );
            } else {
              return Text('data');
            }
          },
        ),
      ),
    );
  }
}
