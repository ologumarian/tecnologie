import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/project.dart';

class Projects with ChangeNotifier {
  List<Project> _items = [];
  String _uid = '';
  String _username = '';
  String _currentProjectId = '';

  Projects({List<Project> list, String uid, String user}) {
    _items = list;
    _uid = uid;
    _username = user;
  }

  String get currentProjectId {
    return _currentProjectId;
  }

  void setCurrentProjectId(String id) {
    _currentProjectId = id;
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

  Future<void> fetchAndSetProjects() {
    // CollectionReference users = FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(uid)
    //     .collection('projects');

    //     final projects = snapshot.data.docs.map((DocumentSnapshot document) {
    //       return Project(
    //         id: document.id,
    //         date: document.data()['date'].toDate(),
    //         description: document.data()['description'],
    //         imageLink: document.data()['imageLink'],
    //         name: document.data()['name'],
    //         owner: document.data()['owner'],
    //       );
    //     }).toList();

    // StreamBuilder<QuerySnapshot>(
    //   stream: users.snapshots(),
    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     if (snapshot.hasError) {
    //       return Center(child: Text('Qualcosa è andatpo storto :('));
    //     }
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(child: CircularProgressIndicator());
    //     }
    //     if (snapshot.data.docs.isEmpty) {
    //       NotFoundWidget(tipo: messageType.Projects);
    //     }
    // );

    return null;
  }

  Future<void> addProject({String name, String desc, String imageLink}) {
    var date = DateTime.now();
    var item = Project();

    CollectionReference projects = FirebaseFirestore.instance
        .collection('users')
        .doc(_uid)
        .collection('projects');

    final response = projects.add({
      'name': name,
      'date': date,
      'description': desc,
      'imageLink': imageLink,
      'owner': _username,
    }).then((value) {
      print('FIRESTORE DOCUMENT ID: ' + value.id);
      item = Project(
        id: value.id,
        name: name,
        date: date,
        description: desc,
        imageLink: imageLink,
        owner: username,
      );
      _items.insert(0, item);

      print('NOME: ' + item.name);
      print('DATA: ' + item.date.toIso8601String());
      print('DESCRIZIONE: ' + item.description);
      print('LINK: ' + item.imageLink);
      print('PROPRIETARIO: ' + item.owner);
      print('--> NUMERO PROGETTI: ' + items.length.toString());
    }).catchError(
      (onError) => print('ERRORE ADD_PROJECT SU FIRESTORE ' + onError),
    );

    print('PROGETTO AGGIUNTO A FIRESTORE');
    return null;
  }
}
