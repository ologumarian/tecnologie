import 'package:flutter/material.dart';

class Document {
  String id;
  String name;
  String idOwner;
  bool loading;

  Document({
    @required this.id,
    @required this.name,
    this.idOwner = 'user',
    this.loading = false,
  });
}
