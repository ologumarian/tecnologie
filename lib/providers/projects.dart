import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../models/project.dart';

class Projects with ChangeNotifier {
  List<Project> _items = [];
  String _username = '';

  Projects({List<Project> list, String user}) {
    _items = list;
    _username = user;
  }

  List<Project> get items {
    // if (items != null)
    return [..._items];
    // return [];
  }

  String get username {
    return _username;
  }

  Future<void> addProject({String name, String desc, String imageLink}) {
    Project item = Project(
      id: '',
      name: name,
      date: DateTime.now(),
      description: desc,
      imageLink: imageLink,
      owner: username,
    );

    print(item.name);
    print(item.date);
    print(item.description);
    print(item.imageLink);
    print(item.owner);
    return null;
  }
}
