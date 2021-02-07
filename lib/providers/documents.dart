import 'dart:io';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../models/document.dart';

class Documents with ChangeNotifier {
  String _idCollection;
  List<Document> _items = [];

  List<Document> get items {
    return [..._items];
  }

  // Future<void> fetchAndSetDocuments() async {
  //   return null;
  // }

  void setCollection(String collection) {
    _idCollection = collection;
  }

  void uploadToFirebase(List<String> paths) {
    for (int i = 0; i < paths.length; i++) {
      String filePath = paths[i];
      String fileName = paths[i].split('/').last;
      _upload(fileName, filePath);
    }
  }

  Future<void> _upload(fileName, filePath) async {
    // _extensions = fileName.toString().split('.').last;
    String refPath = _idCollection + '/' + fileName; //percorso del file nel db

    File file = File(filePath); //Fetch file dalla memoria del telefono
    //Importante! Usare prefisso as sulla libreria dart.html

    firebase_storage.SettableMetadata metadata =
        firebase_storage.SettableMetadata(
      cacheControl: '',
      customMetadata: <String, String>{
        'username': 'user',
        'project': _idCollection,
        'date': DateTime.now().toIso8601String(),
      },
    );

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref(refPath)
          .putFile(file, metadata);
    } on FirebaseException catch (e) {
      SnackBar(content: Text('ERRORE nel caricamento'));
    }
    print("FIREBASE - STORAGE: Caricamento di $fileName completato");
  }
}
