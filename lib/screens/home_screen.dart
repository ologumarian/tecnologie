import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  final dimBackButton = 34.0;

  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawerOpen ? -0.5 : 0),
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          //DROP SHADOW PER SCREEN ON DRAWER OPENING
          // decoration: BoxDecoration(
          //   boxShadow: [
          //     BoxShadow(
          //       color: Colors.black26,
          //       blurRadius: 15,
          //       spreadRadius: 9,
          //       offset: const Offset(-10, 10),
          //     )
          //   ],
          // ),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //DRAWER/BACK BUTTON
                      isDrawerOpen
                          ? IconButton(
                              icon: Icon(Icons.arrow_back_ios),
                              iconSize: dimBackButton,
                              onPressed: () {
                                setState(() {
                                  xOffset = 0;
                                  yOffset = 0;
                                  scaleFactor = 1;
                                  isDrawerOpen = false;
                                });
                              },
                            )
                          : IconButton(
                              icon: Icon(Icons.menu),
                              iconSize: dimBackButton,
                              onPressed: () {
                                setState(() {
                                  xOffset = 230;
                                  yOffset = 150;
                                  scaleFactor = 0.6;
                                  isDrawerOpen = true;
                                });
                              }),

                      //SCREEN TITLE
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Documentive',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: dimBackButton,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
