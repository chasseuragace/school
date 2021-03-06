import 'package:flutter/material.dart';
import 'package:schoolapp/screens/navigation_wrapper/school_detils_controller.dart';

import '../../const.dart';
import '../../template.dart';

class AppDrawerSchoolBakgroundNameAndLogo extends StatelessWidget {
  const AppDrawerSchoolBakgroundNameAndLogo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return schoolManager.mamage(
        error: (s) => Text('$s'),
        loaded: (school) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                borderRadius: BorderRadius.circular(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/intro1.png",
                            ),
                    fit: BoxFit.cover,
                    colorFilter:
                        ColorFilter.mode(Colors.black45, BlendMode.darken))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white70,
                    child: Image.asset(
                      schoolLogo,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                ColoredBox(
                  color: Colors.black54,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${school.schoolName}",
                                  textAlign: TextAlign.center,
                                  style: Constants.titleWhite
                                      .copyWith(fontSize: 16),
                                ),
                        Text(
                          "${school.address}",
                                  textAlign: TextAlign.center,
                                  style: Constants.titleWhite
                                      .copyWith(fontSize: 14),
                                ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
              ),
            ),
          ),
        ));
  }
}
