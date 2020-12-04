
import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:schoolapp/const.dart';
import '../custom_app_bar.dart';

import 'package:schoolapp/screens/navigation_wrapper/material_notification.dart';
import 'package:schoolapp/simple_utils/widgets.dart';
import 'package:schoolapp/simple_utils/date_formatter.dart';

import 'edit_note.dart';

var attendanceAtrributes = {
  "School Days": "186",
  "Days Attended": "180",

};

class Attendance extends StatelessWidget {
  static const String tag = "attendance";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: makeScaleTween(
        context: context,
        child: Hero(
          tag: "edit",
          child: appButton(
            onTap: ()async {
              var selection= await  showMaterialDateRangePicker(

                helpText: "Select Date/range for leave",

                  builder: (c,child){
                    return Theme(data: ThemeData(primaryColor: Colors.green)  ,child: child,);
                  },
                  context: context,
                  firstDate: NepaliDateTime.now(),
                  lastDate: NepaliDateTime.now()
                      .add(Duration(days: 60)));


              if(selection!=null){
                String selectionText;
                if (selection.start.millisecondsSinceEpoch == selection.end.millisecondsSinceEpoch){
                  selectionText = " on ${selection.start.standard()}";

                }
                else{

                  selectionText = " starting ${selection.start.standard()} to ${selection.end.standard()}";

                }
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) { return EditText(
                    selectionText:selectionText
                ) ;}));
              }

            },
            text: "Request a leave",
            small: true,

          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(tag: tag,title: "Attendance",),
            Row(
              children: [
                statsInChart(context,
                    score: 0.853,
                    minimal: true,
                    overrideWith: 150.0),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 150*.8,

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ...attendanceAtrributes.keys.map((e) => Row(
                          children: [
                            Expanded(flex: 2,child: Text(e,style: Constants.title.copyWith(fontSize: 16),),),
                            Expanded(flex: 1,child: Text(attendanceAtrributes[e],style: Constants.title.copyWith(fontSize: 16),),),
                          ],
                        ))
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Leaves",style: Constants.title,),
            ),
            Expanded(flex:1,child:
              ListView.builder(
                itemCount: 6, itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: MaterialNotification(
                          alert:index==3,
                          title: index==3? "qAbsent - Baisakh 12":"Leave on Baishakh 26",
                          content: index==3? "The student was marked Absent on this date": "With due respect I request you to grant me a half-day leave today for I have to attend a seminar at 1:30 pm at national museums hall.",
                          signedBy: "Sumitra KC",

                        ),
                      ),
                      if(index==5) SizedBox(height: 80,),
                    ],
                  );
              },

              )
              ,)

          ],
        ),
      ),
    );
  }
}



