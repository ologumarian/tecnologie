import 'package:documentive/providers/documents.dart';
import 'package:intl/intl.dart'; //Per la classe DateFormat

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/file_picker.dart';

import '../widgets/documents_list.dart';

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

    //bind del provider dei Documenti
    final documents = Provider.of<Documents>(context);
    documents.setCollection(id);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 280,
              floating: true,
              pinned: true,
              //NOME PROGETTO
              title: Text(
                name,
                style: TextStyle(fontSize: 24),
              ),
              centerTitle: true,
              backgroundColor: Colors.black87,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Stack(
                  fit: StackFit
                      .expand, // importante per il BoxFit.cover delle immagini!!!
                  children: [
                    //IMMAGINE
                    Hero(
                        tag: id + imageLink,
                        child: Image.network(
                          imageLink,
                          fit: BoxFit.cover,
                        )),
                    //SFUMATURA IMMAGINE
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.3, 1],
                          colors: [
                            // Colors.red[900].withAlpha(150),
                            Colors.black.withAlpha(220),
                            Colors.black.withAlpha(75),
                          ],
                        ),
                      ),
                    ),
                    //BODY APPBAR
                    Container(
                      padding: EdgeInsets.only(
                        left: 25,
                        right: 25,
                        bottom: 20,
                        top: 80,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //DESCRIZIONE
                          Text(
                            description,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 3,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          //DETTAGLI
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //DATA CREAZIONE PROGETTO
                              Row(children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  DateFormat('HH:mm - dd MMM yyyy')
                                      .format(date),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ]),
                              //PROPRIETARIO
                              Chip(
                                label: Text(owner),
                                avatar: Icon(
                                  Icons.person_outline,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },

        //LISTA DOCUMENTI
        body: DocumentsList(),
      ),

      //BUTTON AGGIUNGI FILE (Collegato al provider per operazioni di aggiunta documenti)
      floatingActionButton: Consumer<Documents>(
        builder: (ctx, documents, child) => FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            List<String> paths = [];
            try {
              paths = await FilePickerHelper.openFileExplorer();
            } catch (e) {
              print(e);
            }
            documents.uploadToFirebase(paths);
          },
        ),
      ),
    );
  }
}
