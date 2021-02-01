import 'package:flutter/material.dart';

class ProjectScreen extends StatefulWidget {
  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    final id = routeArgs['id'];
    final name = routeArgs['name'];
    final owner = routeArgs['owner'];
    final description = routeArgs['description'];
    final date = routeArgs['date'];
    final imageLink = routeArgs['imageLink'];

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 300,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(name),
                background: Image.network(
                  imageLink,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: Center(
          child: Text(description),
        ),
      ),
    );

    // return CustomScrollView(
    //   slivers: [
    //     // SliverAppBar(
    //     //   floating: true,
    //     //   expandedHeight: 50,
    //     //   backgroundColor: Colors.transparent,
    //     //   flexibleSpace: FlexibleSpaceBar(
    //     //     title: Text(name),
    //     //   ),
    //     // ),
    //     SliverToBoxAdapter(
    //       child: Stack(
    //         children: [
    //           Container(
    //             height: 200,
    //             width: MediaQuery.of(context).size.width,
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.only(
    //                 bottomLeft: Radius.circular(25),
    //                 bottomRight: Radius.circular(25),
    //               ),
    //             ),
    //             child: Hero(
    //               tag: id,
    //               child: FadeInImage(
    //                 placeholder:
    //                     AssetImage('assets/images/placeholder_documentive.png'),
    //                 image: NetworkImage(imageLink),
    //                 fit: BoxFit.cover,
    //               ),
    //             ),
    //           ),
    //           Container(
    //             decoration: BoxDecoration(
    //               gradient: LinearGradient(
    //                 colors: [Colors.white, Colors.black],
    //                 begin: Alignment.topCenter,
    //                 end: Alignment.bottomCenter,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     SliverFillRemaining(
    //       child: Container(
    //         color: Colors.white,
    //       ),
    //     ),
    //   ],
    // );
    // return Scaffold(
    //   body: Center(
    //     child: GestureDetector(
    //       onTap: () {
    //         Navigator.pop(context);
    //       },
    //       child: Container(
    //         child: Hero(
    //           tag: id,
    //           child: FadeInImage(
    //             placeholder:
    //                 AssetImage('assets/images/placeholder_documentive.png'),
    //             image: NetworkImage(imageLink),
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
