import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../models/project.dart';

class Projects with ChangeNotifier {
  List<Project> _items = [];

  List<Project> get items {
    [..._items];
  }

  Future<void> addProject({String name, String desc, String imageLink}) {
    Project item = Project(
      id: '',
      name: name,
      date: DateTime.now(),
      description: desc,
      imageLink: imageLink,
      owner: 'owner',
    );
  }
}
