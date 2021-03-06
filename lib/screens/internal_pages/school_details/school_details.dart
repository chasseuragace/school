import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:schoolapp/const.dart';
import 'package:schoolapp/screens/internal_pages/custom_app_bar.dart';
import 'package:schoolapp/screens/navigation_wrapper/app_drawer_school_bakground_name_and_logo.dart';
import 'package:schoolapp/screens/navigation_wrapper/school_detils_controller.dart';
import 'package:schoolapp/simple_utils/widgets.dart';

class SchoolDetails extends StatelessWidget {
  static const String tag = "about";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(tag: tag, title: "School Details"),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                      height: 250,
                      child: AppDrawerSchoolBakgroundNameAndLogo()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('About Us', style: Constants.title),
                        schoolManager.mamage(
                            loaded: (school) => Text('${school.description}',
                                style: TextStyle(fontSize: 16)),
                            error: (s) => Text('err')),

                        SizedBox(
                          height: 15,
                        ),
                        //todo contents missing on api
                        /* Text('Our team', style: Constants.title),
                        Text(
                            'We are this and that , established in this year , have been delivering quality education to this and that and other similar text that describes the institute in a minimalistic manner  ',
                            style: TextStyle(fontSize: 16)),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Something relatable', style: Constants.title),
                        Text(
                            'We are this and that , established in this year , have been delivering quality education to this and that and other similar text that describes the institute in a minimalistic manner  ',
                            style: TextStyle(fontSize: 16)),*/
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            applyShade(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 28,
                    tooltip: '+9779862146252',
                    icon: Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    tooltip: 'hamroschool@gmail.com',
                    iconSize: 28,
                    icon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    tooltip: 'www.hamroschool.com',
                    icon: Icon(
                      FontAwesomeIcons.globe,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
