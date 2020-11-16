import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:schoolapp/const.dart';
import 'package:schoolapp/simple_utils/widgets.dart';

var tiles = {
  "Attendance": FontAwesomeIcons.fingerprint,
  "Notification": FontAwesomeIcons.bell,
  "Class Routine": FontAwesomeIcons.clock,
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
            crossAxisCount:  MediaQuery.of(context).orientation==Orientation.portrait?3:5,
            children: tiles.keys
                .map((e) => Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Material(
                        elevation: 1,
                        borderRadius: BorderRadius.circular(6),
                        color: Color(0xfff8f8f8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: (tiles[e] is IconData)
                                  ? Icon(tiles[e])
                                  : SizedBox(
                                      width: 35,
                                      height: 35,
                                      child: Image.asset(
                                        "assets/${tiles[e]}.png",
                                        fit: BoxFit.cover,
                                      )),
                              // child: Icon(Icons.exam),
                            ),
                            Flexible(
                              child: Text(
                                e,
                                style: Constants.title.copyWith(fontSize: 14,),textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class StudentDogTag extends StatelessWidget {
  const StudentDogTag({
    Key key,
    @required this.name,
    @required this.attributes,
  }) : super(key: key);

  final String name;
  final Map<String, String> attributes;
  final height = 135.0;

  @override
  Widget build(BuildContext context) {
    var widthOfImageHolder = MediaQuery.of(context).size.width * .35;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(colors: [
              Constants.darkAccent,
              Colors.green,
              Constants.darkAccent
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              width: widthOfImageHolder,
              height: height,
              color: Colors.white38,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 1,
                  color: Constants.lightAccent.withOpacity(.3),
                  borderRadius: BorderRadius.circular(widthOfImageHolder),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(widthOfImageHolder),
                    child: SizedBox(
                      width: 120 - 16.0,
                      height: 120 - 16.0,
                      child: Image.asset(
                        "assets/user.png",
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          "$name",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Constants.titleWhite.copyWith(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    ...attributes.keys
                        .map((e) => Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 14,
                                          color: Colors.white,
                                          letterSpacing: 1),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Text(attributes[e],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            letterSpacing: 1))),
                              ],
                            ))
                        .toList()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
