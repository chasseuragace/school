import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:schoolapp/const.dart';
import 'package:schoolapp/simple_utils/date_formatter.dart';
import '../custom_app_bar.dart';

class DueDetails extends StatelessWidget {
  Map<String, dynamic> generateDueDetails() {
    return {
      "total": "Rs 2460",
      "previous_remaining": {
        "remaining": "Rs. 5000",
        "deadline": NepaliDateTime.now().standard()
      },
      "payments": [
        "Due payment Rs. 2450 made on ${NepaliDateTime.now().standard()}",
        "Due payment Rs. 2450 made on ${NepaliDateTime.now().standard()}",
        "Due payment Rs. 2450 made on ${NepaliDateTime.now().standard()}",
        "Due payment Rs. 2450 made on ${NepaliDateTime.now().standard()}",
      ]
    };
  }

  static const String tag = "due";

  @override
  Widget build(BuildContext context) {
    var dueDetails = generateDueDetails();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              tag: tag,
              title: 'Due Details',
            ),
            ListTile(
              tileColor: Constants.tilesColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: Constants.title.copyWith(fontSize: 16),
                  ),
                  Text(
                    '${dueDetails['total']}',
                    style: Constants.title.copyWith(fontSize: 16),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              tileColor: Constants.tilesColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Previous Remaining'),
                  Text('${dueDetails['previous_remaining']['remaining']}'),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Deadline'),
                  Text('${dueDetails['previous_remaining']['deadline']}')
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                'Payments',
                style: Constants.title,
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: dueDetails['payments'].length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    tileColor: Constants.tilesColor,
                    title: Text('${dueDetails['payments'][index]}'),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
