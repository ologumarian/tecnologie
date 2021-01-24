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
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: isDrawerOpen
          ? () {
              //chiusura drawer
              setState(() {
                xOffset = 0;
                yOffset = 0;
                scaleFactor = 1;
                isDrawerOpen = false;
              });
            }
          : () {},
      child: AnimatedContainer(
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor)
          ..rotateY(isDrawerOpen ? -0.5 : 0),
        duration: Duration(milliseconds: 350),
        curve: Curves.easeInOutCirc,
        // decoration: BoxDecoration(
        //     color: Colors.grey[200],
        //     borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
        child: Container(
          height: deviceHeight,
          padding: EdgeInsets.only(top: 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            color: Theme.of(context).backgroundColor,
            boxShadow: [
              //DROP SHADOW PER SCREEN ON DRAWER OPENING
              BoxShadow(
                color: Colors.black12,
                blurRadius: 15,
                spreadRadius: 9,
                offset: const Offset(-10, 10),
              )
            ],
          ),
          child: SingleChildScrollView(
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
                          //BUTTON APERTURA DRAWER
                          : IconButton(
                              icon: Icon(Icons.menu),
                              iconSize: dimBackButton,
                              onPressed: () {
                                setState(() {
                                  xOffset = deviceWidth / 2 + 25;
                                  yOffset =
                                      (deviceHeight - deviceHeight * 0.8) / 2;
                                  //yOffset per la metà dello schermo dopo 0.6 scale
                                  scaleFactor = 0.8;
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
                      SizedBox(width: 50)
                    ],
                  ),
                ),
                //INTERFACCIA...
              ],
            ),
          ),
        ),
      ),
    );
  }
}
