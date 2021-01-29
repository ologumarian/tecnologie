import 'package:flutter/material.dart';

class ProjectItem extends StatelessWidget {
  final String id;
  final String name;
  final String owner;
  final String description;
  final DateTime date;
  final String imageLink;

  ProjectItem({
    @required this.id,
    @required this.name,
    @required this.owner,
    this.description,
    this.date,
    this.imageLink,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(30),
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                color: Colors.grey[300],
                offset: Offset(4, 4),
              )
            ],
          ),
        ),
        Positioned(
          top: 15,
          left: 50,
          child: Container(
            width: 150,
            height: 230,
            //color: Theme.of(context).bottomAppBarColor,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  color: Colors.black12,
                  offset: Offset(4, 4),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder:
                    AssetImage('assets/images/placeholder_documentive.png'),
                image: NetworkImage(imageLink),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ],
    );
  }
}
