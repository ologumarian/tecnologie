import 'package:flutter/material.dart';

class Document {
  String id;
  String name;
  String idOwner;

  Document({
    @required this.id,
    @required this.name,
    this.idOwner,
  });
}
