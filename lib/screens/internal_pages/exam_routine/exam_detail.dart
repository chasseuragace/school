import 'package:flutter/material.dart';
import 'package:schoolapp/screens/internal_pages/custom_app_bar.dart';
import 'package:schoolapp/screens/internal_pages/exam_routine/heading.dart';
import 'package:schoolapp/simple_utils/widgets.dart';

class ExamDetails extends StatelessWidget {
  const ExamDetails({
    Key key,
    @required this.exams,
    @required this.examNames, this. index, this.cls, this. tag,
  }) : super(key: key);

  final Map exams;
  final String cls;
  final int index;
  final List examNames;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(

          children: [
            CustomAppBar(tag: tag, title: "$cls Exam Routine",customAsset: 'exam',),
            SizedBox(height:  MediaQuery.of(context).size.height*.3,child:
            makeScaleTween(context: context,child: Image.asset('assets/examImg.png',fit: BoxFit.contain,)),),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0),
              child: ColoredBox(
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:8.0),
                  child: const Heading(headings: ["Date", 'Subject','Time'],),
                ),
              ),
            ),
          Expanded(flex: 1,child: ListView(
            children: [
              ...(exams[examNames[index]][cls]
              as Map<dynamic, dynamic>)
                  .keys
                  .map((sub) => Padding(
                padding:
                const EdgeInsets.symmetric(
                    horizontal: 8.0,vertical: 4),
                child: Material(
                  elevation: 1,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: 50
                    ),
                    child: Padding(
                      padding:
                      const EdgeInsets.all(
                          8.0),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                        children: [
                          ...(exams[examNames[
                          index]]
                          [cls][sub]
                          as List<
                              dynamic>)
                              .map((e) =>
                              Flexible(
                                  child: Text(
                                    e,
                                    textAlign:
                                    TextAlign
                                        .center,
                                  )))
                        ],
                      ),
                    ),
                  ),
                ),
              ))
            ],
          ))
          ],
        ),
      ),
    );
  }
}