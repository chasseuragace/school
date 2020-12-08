import 'package:flutter/material.dart';
import 'package:schoolapp/screens/internal_pages/homework/homework_expansion_tile.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:schoolapp/const.dart';
import 'package:schoolapp/screens/internal_pages/custom_app_bar.dart';

class Homework extends StatelessWidget {
  static const String tag = "homework";
  final ValueNotifier<String> monthNotifier = ValueNotifier<String>(
      Constants.monthsNep['${NepaliDateTime.now().month}']);

  @override
  Widget build(BuildContext context) {
    final homework = getHOmework();
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          CustomAppBar(tag: tag, title: "Daily Homework"),
          Material(
            color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text('Homework of month :',style: Constants.title.copyWith(fontSize: 16),),
                  ),
                  ValueListenableBuilder(
                    valueListenable: monthNotifier,
                    builder: (BuildContext context, monthName, Widget child) {
                      return Row(
                        children: [
                          DropdownButton<String>(
                            underline: Container(
                              height: 2,
                              color: Colors.grey[300],
                            ),
                            value: monthName,
                            icon: Icon(Icons.calendar_today_outlined),
                            iconSize: 24,
                            elevation: 16,
                            onChanged: (String newValue) {
                              monthNotifier.value = newValue;
                            },
                            items: Constants.monthsNep.values
                                .map<DropdownMenuItem<String>>(
                                    (String valueKey) {
                              return DropdownMenuItem<String>(
                                value: valueKey,
                                child: Text(
                                  valueKey,
                                  style: TextStyle(
                                      fontWeight: monthName == valueKey
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: monthNotifier,
              builder: (BuildContext context, String monthName, Widget child) {
                if (homework[monthName] == null) return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height:  MediaQuery.of(context).size.height*.3,

                    child: Image.asset('assets/noHomework.png',fit: BoxFit.contain,),),
                    Text('No homework this month so far!',style: Constants.title.copyWith(fontSize: 24,color: Colors.grey[400]),textAlign: TextAlign.center,),
                  ],
                );
                var homeworkThisMonth =
                    homework[monthName] as Map<String, dynamic>;
                return ListView.builder(
                  key: ValueKey(monthName),
                  itemCount: homeworkThisMonth.keys.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical:6.0),
                      child: Container(
                        color: Colors.grey.withOpacity(.11),
                        child: HomeworkExpansionTile(
                            homeworkThisMonth: homeworkThisMonth,index:index,monthName:monthName),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      )),
    );
  }

  Map<String, dynamic> getHOmework() {
    Map<String, dynamic> map = {
      "Mangsir": {
        "1": {
          'nepali': ["Complete cw and do page 39 Qns", "Babita Chaudhari"],
          'english': ["Read and write essay on your parents", "Aaatma Sapkota"],
          'Science': ["Do project report", "Dr. Subash Pathak"],
        },
        "2": {
          'nepali': ["Complete cw and do page 39 Qns", "Babita Chaudhari"],
          'english': ["Read and write essay on your parents", "Aaatma Sapkota"],
          'Science': ["Do project report", "Dr. Subash Pathak"],
        },
        "3": {
          'nepali': ["Complete cw and do page 39 Qns", "Babita Chaudhari"],
          'english': ["Read and write essay on your parents", "Aaatma Sapkota"],
          'Science': ["Do project report", "Dr. Subash Pathak"],
        },
        "4": {
          'nepali': ["Complete cw and do page 39 Qns", "Babita Chaudhari"],
          'english': ["Read and write essay on your parents", "Aaatma Sapkota"],
          'Science': ["Do project report", "Dr. Subash Pathak"],
        },
      },
      "Poush": {
        "1": {
          'Nepali': ["Complete cw and do page 39 Qns", "Babita Chaudhari"],
          'English': ["Read and write essay on your parents", "Aaatma Sapkota"],
          'Science': ["Do project report", "Dr. Subash Pathak"],
        },
        "2": {
          'Nepali': ["Complete cw and do page 39 Qns", "Babita Chaudhari"],
          'English': ["Read and write essay on your parents", "Aaatma Sapkota"],
          'Science': ["Do project report", "Dr. Subash Pathak"],
        },
        "3": {
          'Nepali': ["Complete cw and do page 39 Qns", "Babita Chaudhari"],
          'English': ["Read and write essay on your parents", "Aaatma Sapkota"],
          'Science': ["Do project report", "Dr. Subash Pathak"],
        },
        "4": {
          'Nepali': ["Complete cw and do page 39 Qns", "Babita Chaudhari"],
          'English': ["Read and write essay on your parents", "Aaatma Sapkota"],
          'Science': ["Do project report", "Dr. Subash Pathak"],
        },
      }
    };
    return map;
  }
}
