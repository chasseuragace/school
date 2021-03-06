import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:schoolapp/const.dart';
import 'package:schoolapp/screens/internal_pages/custom_app_bar.dart';
import 'package:schoolapp/screens/internal_pages/exam_routine/exam_detail.dart';
import 'package:schoolapp/simple_utils/date_formatter.dart';

import 'exam_controller.dart';

Map<dynamic, dynamic> generateExamns() {
  var examNames = [
    "First Term Exam",
    "Mid Term -qualifier  Exam",
    "Mid Term Exam",
    "Final Term-qualifier  Exam",
  ];
  var classNames = [
    "Nursury",
    "LKG",
    "UKG",
    "One",
    "Two",
  ];
  var subjects = [
    "Nepali",
    "GK",
    "Science",
    "Social Studies and long name to blow yur mind",
    "History"
  ];
  var routineMap = {};

  examNames.forEach((examName) {
    var examRoutine = {};
    classNames.forEach((clasS) {
      var classroutine = {};
      subjects.forEach((subject) {
        classroutine.putIfAbsent(
            subject,
                () => [
              NepaliDateTime.now().standard(),
              subject,
              "10:00 AM\n12:00 AM"
            ]);
      });
      examRoutine..putIfAbsent(clasS, () => classroutine);
    });

    routineMap.putIfAbsent(examName, () => examRoutine);
  });
  print(routineMap.toString());
  return routineMap;
}

class ExamRoutine extends StatelessWidget {
  static const String tag = "exam";
  final ValueNotifier<String> selectedExam = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    var exams = generateExamns();
    log(exams.toString());
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(tag: tag, title: "Exam Routine"),
            examManager.mamage(
                error: (e) => Text('error'),
                loaded: (data) {
                  print(data.keys.toList());
                  print(data);
                  return Expanded(
                    flex: 1,
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var examNames = data.keys.toList();
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Container(
                            color:
                                Colors.grey.withOpacity((index + 1) / 2 * .08),
                            child: ExpansionTile(
                              expandedAlignment: Alignment.topLeft,
                              children: [
                                ...(data[examNames[index]]
                                        as Map<dynamic, dynamic>)
                                    .keys
                                    .map((cls) {
                                  String tag = UniqueKey().toString();
                                  return Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Hero(
                                      tag: tag,
                                      child: Material(
                                        child: ListTile(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(builder:
                                                    (BuildContext context) {
                                              return ExamDetails(
                                                  exams: data,
                                                  examNames: examNames,
                                                  index: index,
                                                  cls: cls,
                                                  tag: tag);
                                            }));
                                          },
                                          title: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              cls,
                                              style: Constants.title
                                                  .copyWith(fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                })
                              ],
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      child: Text(
                                    examNames[index],
                                    style:
                                        Constants.title.copyWith(fontSize: 16),
                                  )),
                                  Flexible(
                                    child: Text(
                                      "${data[examNames[index]].keys.first} to ${data[examNames[index]].keys.last} ",
                                      style: Constants.title
                                          .copyWith(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}



