import 'package:flutter/material.dart';

class DocumentItem extends StatefulWidget {
  @override
  _DocumentItemState createState() => _DocumentItemState();
}

class _DocumentItemState extends State<DocumentItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(25),
        height: 120,
        width: MediaQuery.of(context).size.width,
        child: Text('Document'),
      ),
    );
  }
}
