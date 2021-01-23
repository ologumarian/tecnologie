import 'package:flutter/material.dart';

import '../config/configuration.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Theme.of(context).bottomAppBarColor,
        padding: EdgeInsets.only(left: 15, top: 34, bottom: 24, right: 200),
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
                  margin: EdgeInsets.only(top: 20, bottom: 50),
                  child: Text(
                    'Marian Ologu',
                    //'ologumarian2001@gmail.com',
                    softWrap: true,
                    //overflow: TextOverflow.fade,
                    style: TextStyle(
                      color: Colors.grey[100],
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                                  color: Colors.white,
                                  size: 30,
                                ),
                                SizedBox(width: 10),
                                Text(element['title'],
                                    style: TextStyle(
                                      color: Colors.white,
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
            Row(
              children: [
                Icon(Icons.exit_to_app, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  'Log out',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
