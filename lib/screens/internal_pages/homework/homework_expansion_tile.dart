import 'package:flutter/material.dart';

import '../../../const.dart';

class HomeworkExpansionTile extends StatelessWidget {
  const HomeworkExpansionTile({
    Key key,
    @required this.homeworkThisMonth, this. index, this. monthName,
  }) : super(key: key);

  final Map<String, dynamic> homeworkThisMonth;
  final int index;
  final String monthName;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text("$monthName ${homeworkThisMonth.keys.toList()[index]}"),
      children: [
        ...homeworkThisMonth[homeworkThisMonth.keys.toList()[index]]
            .keys
            .map((e) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Material(
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:12.0,horizontal: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text(
                                '$e:',
                                style: Constants.title.copyWith(fontSize: 16),
                              )),
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // ...homeworkThisMonth[homeworkThisMonth.keys.toList()[index]][e].map((c)=>Flexible(child: Text(c))),
                                Text(
                                  homeworkThisMonth[homeworkThisMonth.keys
                                      .toList()[index]][e][0],
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  '-${homeworkThisMonth[homeworkThisMonth.keys.toList()[index]][e][1]}',
                                  style: Constants.title.copyWith(fontSize: 10),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
      ],
    );
  }
}
