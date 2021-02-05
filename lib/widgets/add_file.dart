// import 'dart:html' as html;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:http/http.dart' as http;

class AddFile extends StatefulWidget {
  final String idCollection;

  AddFile({@required this.idCollection});

  @override
  _AddFileState createState() => _AddFileState();
}

class _AddFileState extends State<AddFile> {
  FilePickerResult _result;
  List<String> _paths;
  List<File> _files;

  String _extensions;
  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  // List<StorageEvent> task = <StorageEvent>[];

  //FX per apertura file
  openFileExplorer() async {
    try {
      _paths = [];
      _result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['doc', 'pdf', 'docx'],
      );

      if (_result != null) {
        //Creo una lista di files partendo dal result del picker
        _files = _result.paths.map((path) => File(path)).toList();

        Iterator<PlatformFile> _platformFiles = _result.files.iterator;
        while (_platformFiles.moveNext()) {
          //salvataggio path nella lista
          _paths.add(_platformFiles.current.path);
          print("FILE SEELEZIONATO");
          print("Nome File: " + _platformFiles.current.name);
          print("Bytes: " + _platformFiles.current.bytes.toString());
          print("Dimensione: " + _platformFiles.current.size.toString());
          print("Estensione: " + _platformFiles.current.extension);
          print("Percorso" + _platformFiles.current.path);
        }
        upLoadToFirebase();
      } else {
        // L'utente annulla l'operazione
      }
    } on PlatformException catch (e) {
      print('Unsopported operation' + e.toString());
    }
    if (!mounted) {
      return;
    }
  }

  upLoadToFirebase() {
    for (int i = 0; i < _paths.length; i++) {
      String filePath = _paths[i];
      String fileName = _paths[i].split('/').last;
      upload(fileName, filePath);
    }
  }

  Future<void> upload(fileName, filePath) async {
    _extensions = fileName.toString().split('.').last;
    String refPath =
        widget.idCollection + '/' + fileName; //percorso del file nel db

    File file = File(filePath); //Fetch file dalla memoria del telefono
    //Importante! Usare prefisso as sulla libreria dart.html

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref(refPath)
          .putFile(file);
    } on FirebaseException catch (e) {
      SnackBar(content: Text('ERRORE nel caricamento'));
    }
    print("FIREBASE - STORAGE: Caricamento di $fileName completato");
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => openFileExplorer(),
    );
  }
}
