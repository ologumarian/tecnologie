import 'package:flutter/material.dart';

class Project {
  final String id;
  final String name;
  final String owner;
  final String description;
  final DateTime date;
  final String imageLink;

  Project({
    @required this.id,
    this.name,
    this.owner,
    this.description,
    this.date,
    this.imageLink,
  });
}

final DUMMY_PROJECTS = [
  Project(
    id: 'p1',
    name: 'Progetto 1',
    owner: 'Marian',
    description: 'App social dedicata ad un target giovanile',
    date: DateTime.now(),
    imageLink:
        'https://www.infocube.it/iccd/uploads/2018/01/time-to-share-x.jpg',
  ),
  Project(
    id: 'p2',
    name: 'Progetto 2',
    owner: 'Erik',
    description: 'Twitch live stream notes',
    date: DateTime.now(),
    imageLink:
        'https://www.infocube.it/iccd/uploads/2018/01/time-to-share-x.jpg',
  ),
];
