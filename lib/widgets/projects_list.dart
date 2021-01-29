import 'package:flutter/material.dart';

import '../models/project.dart';

import '../widgets/project_item.dart';

class ProjectsList extends StatefulWidget {
  var disableScroll =
      false; //Se true significa che il drawer è aperto quindi disabilito le gesture sulla lista

  ProjectsList(this.disableScroll);

  @override
  _ProjectsListState createState() => _ProjectsListState();
}

class _ProjectsListState extends State<ProjectsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: widget.disableScroll
          ? const NeverScrollableScrollPhysics()
          : const AlwaysScrollableScrollPhysics(),
      itemCount: DUMMY_PROJECTS.length,
      itemBuilder: (context, index) => ProjectItem(
        id: DUMMY_PROJECTS[index].id,
        name: DUMMY_PROJECTS[index].name,
        owner: DUMMY_PROJECTS[index].owner,
        description: DUMMY_PROJECTS[index].description,
        date: DUMMY_PROJECTS[index].date,
        imageLink: DUMMY_PROJECTS[index].imageLink,
      ),
    );
  }
}
