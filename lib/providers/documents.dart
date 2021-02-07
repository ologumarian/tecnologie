import 'dart:io';

import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../models/document.dart';

class Documents with ChangeNotifier {
  String _idCollection;
  List<firebase_storage.UploadTask> _uploads = [];
  List<Document> _items = [];

  List<Document> get items {
    return [..._items];
  }

  void setCollection(String collection) {
    if (collection != _idCollection) {
      _items.clear();
      _idCollection = collection;
      _fetchAndSetDocuments();
    }
  }

  Future<void> _fetchAndSetDocuments() async {
    firebase_storage.ListResult result = await firebase_storage
        .FirebaseStorage.instance
        .ref(_idCollection)
        .listAll();

    result.items.forEach((firebase_storage.Reference ref) {
      print('FILE TROVATO: $ref');
      _items.add(Document(id: ref.name, name: ref.name));
    });
    notifyListeners();
  }

  void uploadToFirebase(List<String> paths) {
    for (int i = 0; i < paths.length; i++) {
      String filePath = paths[i];
      String fileName = paths[i].split('/').last;
      _uploadTask(fileName, filePath);
    }
    _fetchAndSetDocuments();
  }

  Future<void> _uploadTask(fileName, filePath) async {
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

    firebase_storage.UploadTask task = firebase_storage.FirebaseStorage.instance
        .ref(refPath)
        .putFile(file, metadata);

    _uploads.add(task);

    task.snapshotEvents.listen(
      (firebase_storage.TaskSnapshot snapshot) {
        //Eventi dello Snapshot (barra caricamento)
      },
      onError: (e) {
        if (e.code == 'canceled') {
          SnackBar(content: Text('Il caricamento è stato interrotto'));
        }
        if (task.snapshot.state == firebase_storage.TaskState.canceled) {
          SnackBar(content: Text('Caricamento è stato annullato'));
        }
        print(firebase_storage.TaskState.error);
      },
      onDone: () {
        print("FIREBASE - STORAGE: Caricamento di $fileName completato");
      },
    );

    notifyListeners();
    // // Cancel the upload.
    // bool cancelled = await task.cancel();
    // print('cancelled? $cancelled');

    // // Pause the upload.
    // bool paused = await task.pause();
    // print('paused, $paused');

    // // Resume the upload.
    // bool resumed = await task.resume();
    // print('resumed, $resumed');
  }
}
