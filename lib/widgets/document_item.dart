import 'package:flutter/material.dart';

import '../models/document.dart';

class DocumentItem extends StatefulWidget {
  Document docData;

  DocumentItem(this.docData);

  @override
  _DocumentItemState createState() => _DocumentItemState();
}

class _DocumentItemState extends State<DocumentItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: Colors.grey[300],
            offset: Offset(4, 4),
          )
        ],
      ),
      child: Column(
        children: [
          Text(widget.docData.id),
          Text(widget.docData.name),
          // Text(doc.idOwner),
          // doc.loading ? CircularProgressIndicator() : Icons.done
        ],
      ),
    );
  }
}
