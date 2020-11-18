import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as np;
import 'package:schoolapp/screens/navigation_wrapper/material_notification.dart';
import 'package:schoolapp/screens/page_title_with_icon.dart';
import 'package:nepali_utils/nepali_utils.dart';
import '../const.dart';

class CalenderPage extends StatefulWidget {
  @override
  _CalenderPageState createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  var currentDate =np.NepaliDateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: Constants.padding,
        child: Column(
          children: [
            PageTitleWithIcon(
              title: "Calendar",
              icon: Icon(
                Icons.calendar_today_rounded,
                color: Colors.white,
              ),
            ),
            Expanded(
              flex: 1,
              child: MediaQuery.of(context).orientation == Orientation.portrait
                  ? Column(
                      children: [
                        buildcalendar(context),
                        Expanded(
                          flex: 1,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              ...buildEvents(),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: buildcalendar(context),
                        ),
                        Expanded(
                          flex: 1,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              ...buildEvents(),
                            ],
                          ),
                        )
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> buildEvents() {
    return List.generate(
        5,
        (index) => Padding(
          padding: const EdgeInsets.all(3.0),
          child: MaterialNotification(
                compact: true,
                title: "Dashai Holidays",
                content: "yeti gate dekhi uti gate samma",
              ),
        ));
  }

  Widget buildcalendar(context) {
   DateTime.now().toNepaliDateTime();
    return SizedBox(
      height: MediaQuery.of(context).size.height *
          ((MediaQuery.of(context).orientation == Orientation.portrait)
              ? 0.35
              : 1),
      child: np.CalendarDatePicker(
       
onDisplayedMonthChanged: (da){
  currentDate= da;
},
        selectedDayDecoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
            border: Border.fromBorderSide(BorderSide(color: Colors.green))),
        todayDecoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.fromBorderSide(BorderSide(color: Colors.green))),
        initialDate: currentDate,
        firstDate: np.NepaliDateTime(2070),
        lastDate: np.NepaliDateTime(2090),
        onDateChanged: (date) => null,
      ),
    );
  }
}
