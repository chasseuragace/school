import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:schoolapp/const.dart';
import 'package:schoolapp/screens/internal_pages/custom_app_bar.dart';
import 'package:schoolapp/screens/internal_pages/exam_routine/exam_routine.dart';
import 'package:schoolapp/screens/internal_pages/exam_routine/heading.dart';
import 'package:schoolapp/simple_utils/date_formatter.dart';
import 'package:schoolapp/simple_utils/widgets.dart';



generateRoutine() {
  var routine = {
    "09:30 AM \n10:20 AM": ['Nepali', 'Rajendra Dahal'],
    "10:25 AM \n11:10 AM": ['English', 'B.K Sitaula'],
    "11:15 AM \n11:45 AM": ['HydroElectricity and Motor Operation', 'Ramailo hai gaiz'],
    "11:45 AM \n12:30 PM": ['Clemical Bonds and their Equivalence', 'Prof. Narendra Subba'],
  };
  Map<String, dynamic> map = {};
  List<String> days = [];
  for (int i = -3; i < 4; i++) {
    days.add(NepaliDateTime.now().add(Duration(days: i)).standardWithDay());
  }
  days.forEach((element) {
    map.putIfAbsent(element, () => element.contains("Monday")?null:routine);
  });
  return map;
}

class ClassRoutine extends StatefulWidget {
  static const String tag = "routine";

  @override
  _ClassRoutineState createState() => _ClassRoutineState();
}

class _ClassRoutineState extends State<ClassRoutine> {
  ValueNotifier<int> selectedDate;
  Map<String, dynamic> _classRoutine;
  PageController _pageController;
  bool restrictStagger = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _classRoutine = generateRoutine();
    selectedDate = ValueNotifier<int>(3)
      ..addListener(() {
        if (!restrictStagger)
          _pageController.animateToPage(selectedDate.value,
              curve: Curves.easeOutCubic,
              duration: Duration(milliseconds: 400));
      });
    _pageController = PageController(initialPage: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(tag: ClassRoutine.tag, title: "Class Routine"),
            _daysScroll(),
            Heading(headings: ['Time',"Subject","Teacher"],),
            Expanded(
              flex: 1,
              child: PageView.builder(
                itemCount: 7,
                //  physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: (current) {
                  restrictStagger = true;
                  selectedDate.value = current;
                  restrictStagger = false;
                },
                itemBuilder: (BuildContext context, int index) {
                  Map<String, List<String>> data =
                      _classRoutine[(_classRoutine.keys.toList()[index])];

                  return data==null? makeScaleTween(
                    context: context,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/chill.png",height:  MediaQuery.of(context).size.height*.3,),
                          Text( "Some days are better not scheduled",style: Constants.title.copyWith(fontSize: 24,color: Colors.grey[400]),)
                        ],),
                  ): ListView(
                    children: [
                      ...data.keys.map((e) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal:2.0,vertical: 6),
                            child: Material(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .8 /
                                          3,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          e,style: Constants.title.copyWith(fontSize: 14),textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    ...data[e].map((e) => Flexible(
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .8 /
                                                3,
                                            child: Text(
                                              e,
                                              textAlign: TextAlign.center,
                                              style: Constants.title.copyWith(fontSize: 14),
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ))
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  ValueListenableBuilder<int> _daysScroll() {
    return ValueListenableBuilder(
            builder: (BuildContext context, value, Widget _) {
              return makeScaleTween(
                context: context,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: (value - 1 >= 0)
                            ? () {
                                selectedDate.value -= 1;
                              }
                            : null,
                        icon: Icon(Icons.arrow_back_ios),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(
                            _classRoutine.keys.toList()[value],
                            style: Constants.title.copyWith(fontSize: 16),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: (value + 1 < 7)
                            ? () {
                                selectedDate.value += 1;
                              }
                            : null,
                        icon: RotatedBox(
                            quarterTurns: 2,
                            child: Icon(Icons.arrow_back_ios)),
                      )
                    ],
                  ),
                ),
              );
            },
            valueListenable: selectedDate,
          );
  }
}
