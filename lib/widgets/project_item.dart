import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class ProjectItem extends StatelessWidget {
  final String id;
  final String name;
  final String owner;
  final String description;
  final DateTime date;
  final String imageLink;

  ProjectItem({
    @required this.id,
    @required this.name,
    @required this.owner,
    this.description,
    this.date,
    this.imageLink,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //CARD SOTTOSTANTE
        Container(
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
          height: 200,
          margin: EdgeInsets.all(30),
          padding: EdgeInsets.only(left: 190, top: 15, right: 15, bottom: 15),
          //Colonna dati progetto
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //NOME PROGETTO
              Text(
                name,
                overflow: TextOverflow.fade,
                softWrap: true,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              //PROPRIETARIO
              Chip(
                label: Text(owner),
                avatar: Icon(
                  Icons.person_outline,
                  size: 20,
                ),
              ),

              //DESCRIZIONE
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    description,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ),
              SizedBox(
                //compensa il padding della chip per bilanciare l'Expanded
                height: 8,
              ),

              //DATA CREAZIONE
              Row(children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 15,
                  color: Colors.grey[600],
                ),
                SizedBox(width: 5),
                Text(
                  DateFormat('HH:mm - dd MMM yyyy').format(date),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ])
            ],
          ),
        ),

        //CARD IMMAGINE DI COPERTINA
        Positioned(
          top: 15,
          left: 50,
          child: Container(
            width: 150,
            height: 230,
            //color: Theme.of(context).bottomAppBarColor,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  color: Colors.black12,
                  offset: Offset(4, 4),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder:
                    AssetImage('assets/images/placeholder_documentive.png'),
                image: NetworkImage(imageLink),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ],
    );
  }
}
