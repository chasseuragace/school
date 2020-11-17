
import 'package:flutter/material.dart';
import 'package:schoolapp/const.dart';

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