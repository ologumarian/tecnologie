// import 'dart:html' as html;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:http/http.dart' as http;

class ProjectScreen extends StatefulWidget {
  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    final id = routeArgs['id'];
    final name = routeArgs['name'];
    // final owner = routeArgs['owner'];
    final description = routeArgs['description'];
    // final date = routeArgs['date'];
    final imageLink = routeArgs['imageLink'];

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 250,
              floating: true,
              pinned: true,
              backgroundColor: Colors.black87,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(name),
                background: Stack(
                  fit: StackFit
                      .expand, // importante per il BoxFit.cover delle immagini!!!
                  children: [
                    Hero(
                        tag: id + imageLink,
                        child: Image.network(
                          imageLink,
                          fit: BoxFit.cover,
                        )),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            // Colors.red[900].withAlpha(150),
                            Colors.transparent,
                            Colors.black.withAlpha(200),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Center(
          child: Text(description),
        ),
      ),
      //passo l'id del progetto che costituisce il path della collection del rispettivo progetto
      floatingActionButton: AddFile(
        idCollection: id,
      ),
    );
  }
}

class AddFile extends StatefulWidget {
  final String idCollection;

  AddFile({@required this.idCollection});

  @override
  _AddFileState createState() => _AddFileState();
}

class _AddFileState extends State<AddFile> {
  FilePickerResult _result;
  String _path;
  Map<String, String> _paths;
  String _extensions;
  FileType _pickType;
  bool _multiPick = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  // List<StorageEvent> task = <StorageEvent>[];

  //FX per apertura file
  openFileExplorer() async {
    try {
      _result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['doc', 'pdf', 'docx'],
      );

      if (_result != null) {
        _path = _result.paths.first;
        PlatformFile file = _result.files.first;

        print("Nome File: " + file.name);
        print("Bytes: " + file.bytes.toString());
        print("Dimensione: " + file.size.toString());
        print("Estensione: " + file.extension);
        print("Percorso" + file.path);
        print("PATH: " + _path);
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
    String filePath = _path;
    String fileName = _path.split('/').last;
    upload(fileName, filePath);
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
      SnackBar(content: Text('Errore nel caricamento'));
    }
    print("Caricamento di $fileName completato");
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => openFileExplorer(),
    );
  }
}
