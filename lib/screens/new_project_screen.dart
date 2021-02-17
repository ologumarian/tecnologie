import 'package:flutter/material.dart';

import '../widgets/new_project_form.dart';

class NewProjectScreen extends StatefulWidget {
  @override
  _NewProjectScreenState createState() => _NewProjectScreenState();
}

class _NewProjectScreenState extends State<NewProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crea un nuovo progetto'),
        backgroundColor: Colors.black87,
      ),
      body: NewProjectForm(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton.extended(
      //   icon: Icon(
      //     Icons.add,
      //     color: Colors.grey[100],
      //   ),
      //   label: Text('Crea Progetto'),
      //   elevation: 9,
      //   onPressed: () {},
      // ),
    );
  }
}
