import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:documentive/providers/auth_provider.dart';
import 'package:documentive/widgets/not_found_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/project_item.dart';

class ProjectsList extends StatefulWidget {
  final disableScroll; //Se true significa che il drawer è aperto quindi disabilito le gesture sulla lista
  final Function closeDrawer;

  ProjectsList(
    this.disableScroll,
    this.closeDrawer,
  );

  @override
  _ProjectsListState createState() => _ProjectsListState();
}

class _ProjectsListState extends State<ProjectsList> {
  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<AuthProvider>(context).uid;
    CollectionReference users = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('projects');
    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Qualcosa è andatpo storto :('));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return snapshot.data.docs.isEmpty
            ? NotFoundWidget(tipo: messageType.Projects)
            : ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return ProjectItem(
                    id: document.id,
                    date: document.data()['date'].toDate(),
                    description: document.data()['description'],
                    imageLink: document.data()['imageLink'],
                    name: document.data()['name'],
                    owner: document.data()['owner'],
                    isDrawerOpen: widget.disableScroll,
                    closeDrawer: widget.closeDrawer,
                  );
                }).toList(),
              );
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  // return ListView.builder(
  //   physics: widget.disableScroll
  //       ? const NeverScrollableScrollPhysics()
  //       : const AlwaysScrollableScrollPhysics(),
  //   itemCount: DUMMY_PROJECTS.length,
  //   itemBuilder: (context, index) => ProjectItem(
  //     id: DUMMY_PROJECTS[index].id,
  //     name: DUMMY_PROJECTS[index].name,
  //     owner: DUMMY_PROJECTS[index].owner,
  //     description: DUMMY_PROJECTS[index].description,
  //     date: DUMMY_PROJECTS[index].date,
  //     imageLink: DUMMY_PROJECTS[index].imageLink,
  //     isDrawerOpen: widget.disableScroll,
  //     closeDrawer: widget.closeDrawer,
  //   ),
  // );
  // }
}
