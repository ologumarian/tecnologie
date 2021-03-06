import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../models/document.dart';

class DocumentItem extends StatefulWidget {
  final String projId;
  final String docId;
  final Document docData;

  DocumentItem({this.projId, this.docId, this.docData});

  @override
  _DocumentItemState createState() => _DocumentItemState();
}

class _DocumentItemState extends State<DocumentItem> {
  String _docURL = '';
  String _version = 'Unknown';
  String extensionIcon = 'assets/images/placeholder_documentive.png';

  void setExtensionIcon() {
    String ext = widget.docData.id.split('.').last;
    switch (ext) {
      case 'pdf':
        extensionIcon = 'assets/images/pdf.png';
        break;
      case 'doc':
        extensionIcon = 'assets/images/pdf.png';
        break;
      case 'jpg':
        extensionIcon = 'assets/images/jpg.png';
        break;
      case 'png':
        extensionIcon = 'assets/images/png.png';
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    getDocumentURL();
    initPlatformState();
    setExtensionIcon();
  }

  Future<void> getDocumentURL() async {
    String url = await firebase_storage.FirebaseStorage.instance
        .ref('${widget.projId}/${widget.docId}')
        .getDownloadURL();
    await print('DOCUMENT URL: ' + url);
    setState(() {
      _docURL = url;
    });
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
        PdftronFlutter.openDocument(_docURL);
        print('DOCUMENT VIEWER version ' + _version);
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
                    // widget.docData.id.split('.').last == 'pdf'
                    //     ? 'assets/images/pdf.png'
                    //     : 'assets/images/doc.png',
                    extensionIcon,
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
