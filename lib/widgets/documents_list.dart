import 'package:flutter/material.dart';

import '../widgets/document_item.dart';

class DocumentsList extends StatefulWidget {
  @override
  _DocumentsListState createState() => _DocumentsListState();
}

class _DocumentsListState extends State<DocumentsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => DocumentItem(),
    );
  }
}
