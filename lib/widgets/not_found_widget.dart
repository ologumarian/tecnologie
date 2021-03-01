import 'package:flutter/material.dart';

class NotFoundWidget extends StatelessWidget {
  final messageType tipo;

  NotFoundWidget({@required this.tipo});

  @override
  Widget build(BuildContext context) {
    String messaggio;

    switch (tipo) {
      case messageType.Documents:
        messaggio =
            'Nessun documento presente.\nProva ad aggiungerne qualcuno ;)';
        break;
      case messageType.Projects:
        messaggio =
            'Nessun progetto presente.\nProva ad aggiungerne qualcuno ;)';
        break;
      default:
        messaggio = 'Errore 404.\n Not found.';
    }

    var orientation = MediaQuery.of(context).orientation;

    return Center(
      child: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (orientation == Orientation.portrait)
              Center(
                child: Container(
                  height: 100,
                  child: Image.asset('assets/images/large_documentive.png'),
                ),
              ),
            Text(
              messaggio,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            if (orientation == Orientation.portrait)
              SizedBox(
                height: 50,
              )
          ],
        ),
      ),
    );
  }
}

enum messageType {
  Projects,
  Documents,
}
