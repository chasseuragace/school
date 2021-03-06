import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:schoolapp/screens/calendar/calendar_manager.dart';
import 'package:schoolapp/screens/internal_pages/custom_app_bar.dart';
import 'package:schoolapp/screens/navigation_wrapper/material_notification.dart';
import 'package:schoolapp/simple_utils/date_formatter.dart';

class Events extends StatelessWidget {
  static const String tag = "events";

  @override
  Widget build(BuildContext context) {
    var events = generateEvents();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(tag: tag, title: 'Events'),
            eventsManager.manage(
                error: (s) => Text('Error'),
                loaded: (s) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: s.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 6),
                          child: MaterialNotification(
                              compact: true,
                              id: NepaliDateTime.now().add(Duration(days: 5)),
                              title: s[index].notificationTitle,
                              content: s[index].eventDate),
                        );
                      },
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}

Map<String, dynamic> generateEvents() {
  return {
    'sdsd': {
      "name": 'Dashai holiday',
      'date':
          '${NepaliDateTime.now().standard()} to ${NepaliDateTime.now().add(Duration(days: 5)).standard()}'
    },
    'sdssdd': {
      "name": 'That holiday',
      'date': NepaliDateTime.now().add(Duration(days: 5)).standard(),
    },
    'sd': {
      "name": 'This holiday',
      'date': NepaliDateTime.now().standard(),
    },
  };
}
