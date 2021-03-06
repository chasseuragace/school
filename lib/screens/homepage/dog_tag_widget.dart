import 'package:flutter/material.dart';
import 'package:schoolapp/const.dart';
import 'package:schoolapp/screens/profile/profile_manager.dart';

class StudentDogTag extends StatelessWidget {
  const StudentDogTag({
    Key key,
    this.mini = false,
    this.profile,
  }) : super(key: key);

  final bool mini;

  final Profile profile;
  final normalHeight = 135.0;
  final smallHeight = 70.0;

  double get height => mini ? smallHeight : normalHeight;

  get attributes => {
        "Class": profile.className,
        "DOB": profile.dob,
        "Address ": profile.currentAddress,
      };

  @override
  Widget build(BuildContext context) {
    var widthOfImageHolder =
        MediaQuery.of(context).size.width * (mini ? .25 : .35);
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
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
              ),
              alignment: Alignment.center,
              width: widthOfImageHolder,
              height: height,
              child: mini
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://initialstechnology.com/schoolapp/public/${profile.studentPhoto}',
                      ),
                      radius: 30,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        elevation: 1,
                        color: Constants.lightAccent.withOpacity(.3),
                        borderRadius: BorderRadius.circular(widthOfImageHolder),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(widthOfImageHolder),
                          child: SizedBox(
                            width: 120 - 16.0,
                            height: 120 - 16.0,
                            child: Image.network(
                              'https://initialstechnology.com/schoolapp/public/${profile.studentPhoto}',
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
                          "${profile.studentName}",
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
                        .toList().take(mini ? 2 : attributes.length)
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
