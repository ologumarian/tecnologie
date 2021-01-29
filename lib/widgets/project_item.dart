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
    return Container();
  }
}
