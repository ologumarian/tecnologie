import 'package:flutter/material.dart';

class ProjectScreen extends StatefulWidget {
  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    final id = routeArgs['id'];
    final name = routeArgs['name'];
    final owner = routeArgs['owner'];
    final description = routeArgs['description'];
    final date = routeArgs['date'];
    final imageLink = routeArgs['imageLink'];

    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            child: Hero(
              tag: id,
              child: FadeInImage(
                placeholder:
                    AssetImage('assets/images/placeholder_documentive.png'),
                image: NetworkImage(imageLink),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
