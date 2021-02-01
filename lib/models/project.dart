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

// ignore: non_constant_identifier_names
final DUMMY_PROJECTS = [
  Project(
    id: 'p1',
    name: 'OLO Studios',
    owner: 'Marian',
    description: 'App social dedicata ad un target giovanile',
    date: DateTime.now(),
    imageLink:
        'https://images.unsplash.com/photo-1585399000684-d2f72660f092?ixid=MXwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1351&q=80',
  ),
  Project(
    id: 'p2',
    name: 'Vicepredator',
    owner: 'Erik',
    description: 'Twitch live stream notes',
    date: DateTime.now(),
    imageLink:
        'https://images.unsplash.com/photo-1527334919515-b8dee906a34b?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
  ),
  Project(
    id: 'p3',
    name: 'LEANux',
    owner: 'Fabris',
    description: 'Linux spiegato in maniera scialla',
    date: DateTime.now(),
    imageLink:
        'https://images.unsplash.com/photo-1518432031352-d6fc5c10da5a?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1267&q=80',
  ),
  Project(
    id: 'p4',
    name: 'Signora in Grigio',
    owner: 'Erik',
    description: 'How I crack your mother',
    date: DateTime.now(),
    imageLink:
        'https://images.unsplash.com/photo-1598349327904-6b033b8028b2?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MjJ8fGRvY3VtZW50c3xlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
  ),
  Project(
    id: 'p5',
    name: 'Ultra YEs',
    owner: 'Axel',
    description: 'Progetto ultra yes per veri Katon. For real!',
    date: DateTime.now(),
    imageLink:
        'https://images.unsplash.com/photo-1603796846097-bee99e4a601f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1267&q=80',
  ),
];
