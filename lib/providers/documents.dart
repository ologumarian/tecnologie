import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../models/document.dart';

class Documents with ChangeNotifier {
  String _idCollection;
  List<firebase_storage.UploadTask> _uploads;
  List<Document> _items;
  String _uid;

  Documents({
    String idCollection,
    List<firebase_storage.UploadTask> uploads,
    List<Document> items,
    String uid,
  }) {
    _idCollection = idCollection;
    _uploads = uploads;
    _items = items;
    _uid = uid;
  }

  String get idCollection {
    return _idCollection;
  }

  List<firebase_storage.UploadTask> get uploads {
    return _uploads;
  }

  List<Document> get items {
    return [..._items];
  }

  String get uid {
    return _uid;
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
    print('_fetchAndSetDocuments has triggered NOTIFY LISTENERS');
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
        _fetchAndSetDocuments();
      },
    );

    // notifyListeners();

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

  Future<void> getDocumentURL({String projectId, String docName}) async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref()
        // .ref('users/${projectId}/${docName}')
        .getDownloadURL();
  }
}
