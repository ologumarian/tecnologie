import 'package:documentive/models/project.dart';
import 'package:documentive/providers/projects.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/documents.dart';

import '../widgets/document_item.dart';

class DocumentsList extends StatefulWidget {
  @override
  _DocumentsListState createState() => _DocumentsListState();
}

class _DocumentsListState extends State<DocumentsList> {
  @override
  Widget build(BuildContext context) {
    final projectsData = Provider.of<Projects>(context);
    // final documents = documentsData.items;

    return Consumer<Documents>(
      builder: (context, documents, _) {
        return ListView.builder(
          itemCount: documents.items.length,
          itemBuilder: (ctx, i) => DocumentItem(
            docId: documents.items[i].id,
            projId: projectsData.currentProjectId,
            docData: documents.items[i],
          ),
        );
      },
    );
  }
}
