import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

import '../screens/new_project_screen.dart';

import '../widgets/projects_list.dart';

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

  Function closeDrawer() {
    setState(() {
      xOffset = 0;
      yOffset = 0;
      scaleFactor = 1;
      borderRadius = BorderRadius.circular(0);
      isDrawerOpen = false;
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]); //nasconde la status bar
    //final statusBarHeight = MediaQuery.of(context).padding.top;
    final deviceHeight =
        MediaQuery.of(context).size.height; //- statusBarHeight;
    final deviceWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: isDrawerOpen
          ? closeDrawer //chiusura drawer
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
              color: Colors.black26,
              blurRadius: 15,
              spreadRadius: 5,
              offset: const Offset(-10, 10),
            )
          ],
        ),
        padding: EdgeInsets.only(top: 25),
        duration: Duration(milliseconds: 350),
        curve: isDrawerOpen ? Curves.easeOutCubic : Curves.easeInBack,

        //CHILD
        child: Column(
          children: [
            //APPBAR
            Container(
              padding: EdgeInsets.only(right: 25, left: 25, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //SCREEN ICON BUTTON (BACK/DRAWER)
                  Center(
                    child: isDrawerOpen
                        //DRAWER/BACK BUTTON
                        ? IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            iconSize: dimBackButton,
                            onPressed: () {
                              setState(() {
                                //SOLUZIONE PROVVISORIA PER TRIGGERARE IL METODO QUANDO IL DRAWER VIENE REBUILDATO
                                final authData = Provider.of<AuthProvider>(
                                    context,
                                    listen: false);
                                if (authData.username == null) {
                                  authData.fetchAndSetUsername();
                                }
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
                  //PADDING FOR BALANCING Screen Icon
                  SizedBox(width: 50)
                ],
              ),
            ),

            //INTERFACCIA
            Expanded(
              child: Stack(
                children: [
                  //LISTA PROGETTI
                  ProjectsList(
                    isDrawerOpen,
                    closeDrawer,
                  ), //Gli passo la flag per bloccare le gesture quando il drawer è aperto

                  //BUTTON CREA PROGETTO
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: FloatingActionButton.extended(
                      icon: Icon(
                        Icons.add,
                        color: Colors.grey[100],
                      ),
                      label: Text('Crea Progetto'),
                      elevation: 9,
                      onPressed: isDrawerOpen
                          ? () {}
                          : () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (context, _, __) =>
                                      NewProjectScreen(),
                                ),
                              );
                            },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
