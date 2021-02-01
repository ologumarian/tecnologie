import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    final owner = routeArgs['owner'];
    final description = routeArgs['description'];
    final date = routeArgs['date'];
    final imageLink = routeArgs['imageLink'];

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 250,
              //leadingWidth: MediaQuery.of(context).size.width,
              floating: true,
              pinned: true,
              backgroundColor: Colors.black87,
              // backgroundColor: Theme.of(context).bottomAppBarColor,
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
      floatingActionButton: AddFile(),
    );
  }
}

class AddFile extends StatefulWidget {
  @override
  _AddFileState createState() => _AddFileState();
}

class _AddFileState extends State<AddFile> {
  FilePickerResult result;
  String path;
  Map<String, String> paths;
  String extensions;
  FileType pickType;
  bool multiPick = false;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  // List<StorageEvent> task = <StorageEvent>[];

  openFileExplorer() async {
    try {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['doc', 'pdf', 'docx'],
      );

      if (result != null) {
        PlatformFile file = result.files.first;

        print("Nome File: " + file.name);
        print("Bytes: " + file.bytes.toString());
        print("Dimensione: " + file.size.toString());
        print("Estensione: " + file.extension);
        print("Percorso" + file.path);
      } else {
        // User canceled the picker
      }
    } on PlatformException catch (e) {
      print('Unsopported operation' + e.toString());
    }
    if (!mounted) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => openFileExplorer(),
    );
  }
}
