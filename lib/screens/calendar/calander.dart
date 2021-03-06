import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as np;
import 'package:nepali_utils/nepali_utils.dart';
import 'package:schoolapp/screens/navigation_wrapper/material_notification.dart';
import 'package:schoolapp/screens/page_title_with_icon.dart';
import 'package:schoolapp/simple_utils/date_formatter.dart';

import '../../const.dart';
import 'calendar_manager.dart';

class CalenderPage extends StatefulWidget {
  @override
  _CalenderPageState createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage>
    with AutomaticKeepAliveClientMixin {
  ValueNotifier<np.NepaliDateTime> currentDate =
      ValueNotifier<np.NepaliDateTime>(np.NepaliDateTime.now());

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildcalendar(context),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: Constants.padding,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Events",
                                style: Constants.title.copyWith(fontSize: 16),
                              ),
                              ValueListenableBuilder(
                                builder: (BuildContext context, value,
                                    Widget child) {
                                  return Text(
                                    "${Constants.monthsNep["${currentDate.value.month}"]}",
                                    style:
                                        Constants.title.copyWith(fontSize: 16),
                                  );
                                },
                                valueListenable: currentDate,
                              ),
                              IconButton(
                                icon: Icon(Icons.restore),
                                onPressed: () {
                                  currentDate.value = np.NepaliDateTime.now();
                                  setState(() {});
                                },
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          flex: 1,
                          child: ValueListenableBuilder(
                            valueListenable: currentDate,
                            builder: (BuildContext context,
                                NepaliDateTime value, Widget child) {
                              return buildEvents('sd');
                            },
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
                    child: buildEvents('sd'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildEvents(String m) {
    return eventsManager.manage(
        loaded: (eventlist) =>
            ListView(
              shrinkWrap: true,
              children:
              eventlist.map((event) =>
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: MaterialNotification(
                      focused: (currentDate.value.standard() ==
                          DateTime.tryParse(event.eventDate)
                              .toNepaliDateTime()
                              .standard()) ? true : false,
                      compact: true,
                      id: DateTime.tryParse(event.eventDate).toNepaliDateTime(),
                      onTap: (date) {
                        setState(() {
                          currentDate.value = date;
                        });
                      },
                      title:
                      event.notificationTitle,
                      content: DateTime.tryParse(event.eventDate)
                          .toNepaliDateTime()
                          .standard(),
                    ),
                  )).toList(),

            ),


        error: (e) => Text('error'));
  }

  Widget buildcalendar(context) {
    DateTime.now().toNepaliDateTime();
    return SizedBox(
      key: UniqueKey(),
      height: MediaQuery
          .of(context)
          .size
          .height *
          ((MediaQuery
              .of(context)
              .orientation == Orientation.portrait)
              ? 0.35
              : 1),
      child: np.CalendarDatePicker(
        onDisplayedMonthChanged: (da) {
          currentDate.value = da;
        },
        selectedDayDecoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
            border: Border.fromBorderSide(BorderSide(color: Colors.green))),
        todayDecoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.fromBorderSide(BorderSide(color: Colors.green))),
        initialDate: currentDate.value,
        firstDate: np.NepaliDateTime(2070),
        lastDate: np.NepaliDateTime(2090),
        onDateChanged: (date) => null,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
