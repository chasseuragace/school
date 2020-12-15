import 'package:flutter/material.dart';

import '../../const.dart';
import '../../template.dart';

class AppDrawerSchoolBakgroundNameAndLogo extends StatelessWidget {
  const AppDrawerSchoolBakgroundNameAndLogo({
    Key key,
    @required this.name,
    @required this.location = schoolLocationx,
    @required this.backgroundImageUrl,
    @required this.schoolLogoUrl,
  }) : super(key: key);

  final String name;
  final String location;
  final String backgroundImageUrl;
  final String schoolLogoUrl;


  @override
  Widget build(BuildContext context) {
    return Padding(
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
                          "$name",
                          textAlign: TextAlign.center,
                          style: Constants.titleWhite.copyWith(fontSize: 16),
                        ),
                        Text(
                          "$location",
                          textAlign: TextAlign.center,
                          style: Constants.titleWhite.copyWith(fontSize: 14),
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
    );
  }
}
