import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schoolapp/screens/homepage/dog_tag_widget.dart';
import 'package:schoolapp/screens/profile/profile_manager.dart';
import 'package:schoolapp/simple_utils/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../const.dart';

class ProfilePage extends StatefulWidget {
  final Profile profile;

  const ProfilePage({Key key, this.profile}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    print(widget.profile.toString());
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          StudentDogTag(profile: widget.profile),
          Expanded(child: buildDetails(context)),
        ],
      ),
    );
  }

  ListView buildDetails(BuildContext context) {
    var attributes = {
      "Father's Name": widget.profile.fatherName,
      "Mothers's Name": widget.profile.motherName,
      "Local Gudardian's Name": widget.profile.localGuardian,
      "Blood Group": widget.profile.bloodGroup,
      "Current Adress": widget.profile.currentAddress,
    };
    var contacts= {
      /* "Gudardian's Contact\n${widget.profile.l}" : "9862145555",*/
    };
    return ListView(
      shrinkWrap: true,
      children: [
        ...attributes.keys.map((e) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            e,
                            style: Constants.title.copyWith(fontSize: 16),
                          )),
                      Expanded(flex:1,child: Text(attributes[e],style: Constants.title.copyWith(fontSize: 16),)),


                    ],),
                ),
              ),
            )),
        ... contacts.keys.map((e) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () async {
              var url = 'tel:+977${contacts[e]}';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: SizedBox(
              height: 40,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                  children: [
                    Expanded(flex:1,child: Text(e,style: Constants.title.copyWith(fontSize: 16),)),
                    Expanded(flex:1,child: Row(

                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.phone),
                        ),
                        Text(contacts[e],style: Constants.title.copyWith(fontSize: 16),),
                      ],
                    )),


                  ],),
              ),
            ),
          ),
        )),

      ],
    );
  }

  ListView buildListView(BuildContext context) {
    return ListView(
                          children: [
                            findChild(0, context),
                            SizedBox(height: 18,),

                            findChild(2, context),
                            findChild(-1, context),
                          ],
                        );
  }

  findChild(final int index, context) {
    Widget child;
    switch (index) {
      case 0:
        child = Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            statsInChart(context,
                title: "Attendance", score: 37.58 / 100, data: "32/75"),
            statsInChart(context,
                score: 85.66 / 100, title: "Performance", data: "A+"),
          ],
        );
        break;
      case 1:
        child = Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 115,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Participations',
                  style: Constants.title.copyWith(fontSize: 24),
                ),
                SizedBox(height: 5,),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    itemCount: 6,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            Chip(
                              backgroundColor: (index == 1)
                                  ? Colors.brown[200]
                                  : (index == 2)
                                  ? Colors.yellow[200]
                                  : (index == 3)
                                  ? Colors.black12
                                  : Constants.tilesColor,
                              label: Text("This and that compidition  $index"),
                            ),
                            Text("Lead singer")
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
        break;
      case 2:
        child = Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Teacher's remarks",
                  style: Constants.title.copyWith(fontSize: 24),
                ),
                SizedBox(
                  height: 8,
                ),
                Column(
                  children: [
                    ...[1, 2, 3]
                        .map((e) => null)
                        .map((e) =>
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: remarks(),
                        ))
                        .toList()
                  ],
                )
                //remarks()
              ],
            ),
          ),
        );
        break;
      default:
        child = SizedBox(
          height: 66,
        );
    }
    return child;
  }

  Column remarks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Kabita Neupane",
          style: Constants.title
              .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          "-Class teacher",
          style: Constants.title
              .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        Text("noun. an act or instance of participating. "
            "the fact of taking part, as in some action or "
            "attempt: participation in a celebration. a sharing, as in benefits or profits: ")
      ],
    );
  }



  height(context) {
    var mq = MediaQuery.of(context);
    return mq.size .height - mq.padding.top -60-55-205 ;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

var overviewPies = {
  "Attendance"
};