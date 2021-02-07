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
    final documentsData = Provider.of<Documents>(context);
    final documents = documentsData.items;

    return ListView.builder(
      itemCount: documents.length,
      itemBuilder: (ctx, i) => DocumentItem(documents[i]),
    );
  }
}
