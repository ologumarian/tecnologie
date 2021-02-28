import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';

import '../models/document.dart';

class DocumentItem extends StatefulWidget {
  final Document docData;

  DocumentItem(this.docData);

  @override
  _DocumentItemState createState() => _DocumentItemState();
}

class _DocumentItemState extends State<DocumentItem> {
  String _version = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize via an async method.
  Future<void> initPlatformState() async {
    String version;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      PdftronFlutter.initialize('');
      version = await PdftronFlutter.version;
    } on PlatformException {
      version = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _version = version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // https://firebasestorage.googleapis.com/v0/b/app-tecnologie.appspot.com/o/iT0ghv6EeAMB6Kxzu15Z%2FAppunti%20db%20Giornalino.pdf?alt=media&token=6145e4f0-80d6-41ed-8104-49585c5020f8
        PdftronFlutter.openDocument(
            "https://firebasestorage.googleapis.com/v0/b/app-tecnologie.appspot.com/o/iT0ghv6EeAMB6Kxzu15Z%2FAppunti%20db%20Giornalino.pdf?alt=media&token=6145e4f0-80d6-41ed-8104-49585c5020f8");
        print('TAP DOCUMENTO');
      },
      child: Stack(
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
                //NOME FILE
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
      ),
    );
  }
}
