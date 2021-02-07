import 'package:flutter/material.dart';

import '../models/document.dart';

class DocumentItem extends StatefulWidget {
  final Document docData;

  DocumentItem(this.docData);

  @override
  _DocumentItemState createState() => _DocumentItemState();
}

class _DocumentItemState extends State<DocumentItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //CARD SOTTOSTANTE
        Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          padding: EdgeInsets.only(top: 15, bottom: 15, right: 15, left: 150),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.docData.id,
                overflow: TextOverflow.fade,
                softWrap: true,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Text(widget.docData.name),
              // Text(doc.idOwner),
              // doc.loading ? CircularProgressIndicator() : Icons.done
            ],
          ),
        ),
        //ICONA TIPO FILE
        Positioned(
          top: 10,
          left: 40,
          child: Container(
            width: 100,
            height: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                placeholder:
                    AssetImage('assets/images/placeholder_documentive.png'),
                image: AssetImage(
                  widget.docData.id.split('.').last == 'pdf'
                      ? 'assets/images/pdf.png'
                      : 'assets/images/doc.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ],
    );
  }
}
