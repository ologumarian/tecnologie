import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  BorderRadiusGeometry borderRadius = BorderRadius.circular(0);

  final dimBackButton = 34.0;

  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]); //nasconde la status bar
    //final statusBarHeight = MediaQuery.of(context).padding.top;
    final deviceHeight =
        MediaQuery.of(context).size.height; //- statusBarHeight;
    final deviceWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: isDrawerOpen
          ? () {
              //chiusura drawer
              setState(() {
                xOffset = 0;
                yOffset = 0;
                scaleFactor = 1;
                borderRadius = BorderRadius.circular(0);
                isDrawerOpen = false;
              });
            }
          : () {},
      child: AnimatedContainer(
        //ANIMATION
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor),
        //..rotateY(isDrawerOpen ? -0.5 : 0),  //Distorsione asse x
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
          //DROP SHADOW PER SCREEN ON DRAWER OPENING
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              spreadRadius: 9,
              offset: const Offset(-10, 10),
            )
          ],
        ),
        padding: EdgeInsets.only(top: 25, left: 25, right: 25),
        duration: Duration(milliseconds: 350),
        curve: isDrawerOpen ? Curves.easeOutCubic : Curves.easeInBack,

        //CHILD
        child: Column(
          children: [
            //APPBAR
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //ICON BUTTON
                  Center(
                    child: isDrawerOpen
                        //DRAWER/BACK BUTTON
                        ? IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            iconSize: dimBackButton,
                            onPressed: () {
                              setState(() {
                                xOffset = 0;
                                yOffset = 0;
                                scaleFactor = 1;
                                borderRadius = BorderRadius.circular(0);
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
                                borderRadius = BorderRadius.circular(35);
                                isDrawerOpen = true;
                              });
                            }),
                  ),

                  //SCREEN TITLE
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Progetti',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: dimBackButton,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 50)
                ],
              ),
            ),

            //INTERFACCIA..
            Expanded(
              child: Stack(
                children: [
                  //BUTTON CREA PROGETTO
                  Positioned(
                    bottom: 25,
                    right: 0,
                    child: FloatingActionButton.extended(
                      icon: Icon(
                        Icons.add,
                        color: Colors.grey[100],
                      ),
                      label: Text('Crea Progetto'),
                      onPressed: () {},
                    ),
                  ),
                  //ProjectsList(),
                ],
              ),
            ),
          ],
        ),
        // ),
      ),
    );
  }
}
