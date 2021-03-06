import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:schoolapp/const.dart';
import 'package:schoolapp/screens/homepage/dog_tag_widget.dart';
import 'package:schoolapp/screens/homepage/home_page_tile.dart';
import 'package:schoolapp/screens/profile/profile_manager.dart';
import 'package:schoolapp/simple_utils/widgets.dart';
import 'package:schoolapp/template.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          makeSlideTween(
              context: context,
              child: profileManager.mamage(
                  loading: () => CircularProgressIndicator(),
                  loaded: (Profile profile) => StudentDogTag(
                        mini: true,
                        profile: profile,
                      ))),
          SizedBox(
            height: 10,
          ),
          GridView.count(
            padding: Constants.padding,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? 3
                    : 5,
            children: tiles.keys
                .map((e) => Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: GestureDetector(
                        onTap: () {
                          //todo implement routes
                          // Navigator.of(context).pushNamed('/$assetImage');
                        },
                        child: DashBoardTile(
                            tileTitle: e,
                            assetImage: tiles[e],
                            onTap: () {
                              Navigator.of(context).pushNamed('${tiles[e]}');
                            }),
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
