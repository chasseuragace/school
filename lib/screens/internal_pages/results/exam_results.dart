import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:schoolapp/screens/internal_pages/custom_app_bar.dart';

import 'package:schoolapp/screens/internal_pages/results/view_results.dart';

List<String> generateExamNames() {
  var examNames = [
    "First Term Exam",
    "Mid Term -qualifier  Exam",
    "Mid Term Exam",
    "Final Term-qualifier  Exam",
  ];
  return examNames;
}

class ExamResults extends StatelessWidget {
  static const String tag = "result";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(tag: tag, title: "Results"),
            Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: generateExamNames().length,
                  itemBuilder: (BuildContext context, int index) {
                    final tag= generateExamNames()[index]+'$index';
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Container(
                        color: Colors.grey.withOpacity((index + 1) / 2 * .08),
                        child: Hero(
                          tag: tag,
                          child: Material(
                            child: ListTile(
                              title: Text(generateExamNames()[index]),
                              onTap: () async {
                               await setOrientation(context);
                                await Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (c) {
                                  return ViewResults(title:generateExamNames()[index],tag:tag);
                                }));
                                resetOrientation();
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }

  setOrientation(context)async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
if( MediaQuery.of(context).orientation!=Orientation.portrait) {
      await Future.delayed(Duration(milliseconds: 150),);
    }
  }

  resetOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
    ]);
  }
}



