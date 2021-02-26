import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/project.dart';

class Projects with ChangeNotifier {
  List<Project> _items = [];
  String _uid = '';
  String _username = '';

  Projects({List<Project> list, String uid, String user}) {
    _items = list;
    _uid = uid;
    _username = user;
  }

  List<Project> get items {
    return [..._items];
  }

  String get uid {
    return _uid;
  }

  String get username {
    return _username;
  }

  Future<void> fetchAndSetProjects() {}

  Future<void> addProject({String name, String desc, String imageLink}) {
    var date = DateTime.now();
    Project item = Project();

    CollectionReference projects = FirebaseFirestore.instance
        .collection('users')
        .doc(_uid)
        .collection('projects');

    projects.add({
      'name': name,
      'date': date,
      'description': desc,
      'imageLink': imageLink,
      'owner': _username,
    });
    // .then((value) {
    //   item = Project(
    //     id: value.id,
    //     name: name,
    //     date: date,
    //     description: desc,
    //     imageLink: imageLink,
    //     owner: username,
    //   );
    //   _items.add(item);
    // }).catchError(() => print('ERRORE ADD_PROJECT SU FIRESTORE'));

    print('PROGETTO AGGIUNTO A FIRESTORE');

    // print(item.name);
    // print(item.date);
    // print(item.description);
    // print(item.imageLink);
    // print(item.owner);
    // print('Numero progetti:' + items.length.toString());
    return null;
  }
}
