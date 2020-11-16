
import 'package:schoolapp/screens/homepage/home_page_tile.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:schoolapp/const.dart';
import 'package:schoolapp/screens/homepage/dog_tag_widget.dart';
import 'package:schoolapp/simple_utils/widgets.dart';

var tiles = {
  "Attendance": "attendance",
  "Class Routine": "routine",
  "Exam Routine": "exam",
  "Daily Homework": "homework",
  "Results": "result",
  "Project Work": "project",
  "Library": "library",
  "Suggestions": "suggestions",
  "School Details": "about",
  "Language ": "language",
  "Due Dates": "due",
  "Subjects": "subjects",
  "Events": "events",
  "Articles": "article",
};

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Builder(builder: (
            context,
          ) {
            var name = "Thomas Shelby";
            var attributes = {
              "DOB": "Jan 27, 2008",
              "Class": "SIxteen",
              "Section": "Stone Cold",
              "Rank": "12",
            };
            return makeSlideTween(
              context: context,
              child: StudentDogTag(name: name, attributes: attributes),
            );
          }),
          GridView.count(
            padding: Constants.padding,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? 3
                    : 5,
            children: tiles.keys.map((e) => Padding(
              padding: const EdgeInsets.all(3.0),
              child: GestureDetector(
                onTap: () {
                  //todo implement routes
                  // Navigator.of(context).pushNamed('/$assetImage');
                },
                child: DashBoardTile(tileTitle: e,assetImage: tiles[e],),
              ),
            )).toList(),
          )
        ],
      ),
    );
  }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
