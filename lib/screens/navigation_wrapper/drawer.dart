import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:schoolapp/screens/login/login_manager.dart';
import 'package:schoolapp/screens/navigation_wrapper/app_drawer_school_bakground_name_and_logo.dart';
import 'package:schoolapp/screens/navigation_wrapper/material_notification.dart';
import 'package:schoolapp/screens/notification/notification_manager.dart';
import 'package:schoolapp/simple_utils/date_formatter.dart';
import 'package:schoolapp/template.dart';

import '../../const.dart';

class AppDrawer extends StatelessWidget {
  final String name;

  const AppDrawer({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            //color: Colors.grey,
            width: MediaQuery.of(context).size.width * .6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppDrawerSchoolBakgroundNameAndLogo(),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      NepaliDateTime.now().standard(),
                      style: Constants.title,
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  child: Text(
                    "Recent Updates",
                    style: Constants.title.copyWith(fontSize: 14),
                  ),
                ),
                Expanded(
                  child: false
                        ? FittedBox(
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                            child: noNotifications(context, inDrawer: true))
                        : notificationManager.manage(
                            loaded: (List<Schoolnotifications> notifications) =>
                                ListView.builder(
                                  itemCount: notifications.length,
                                  padding: EdgeInsets.zero,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var data = notifications[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Dismissible(
                                        key: UniqueKey(),
                                        onDismissed: (dir) {
                                          //todo mark as read , put user id in notification read array, firebse
                                        },
                                        child: MaterialNotification(
                                          date:
                                              DateTime.tryParse(data.createdAt)
                                                  .toNepaliDateTime()
                                                  .standard(),
                                          compact: true,
                                          title: data.notificationTitle,
                                          content: data.notification,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                            loading: () => Text('ing'),
                            error: (err) => Text('err'))),
              ],
            ),
          ),
        ),
        Center(
          child: IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Provider.of<LoginManger>(context, listen: false)
                  .logout(() => print("error logout"));
            },
          ),
        )
      ],
    );
  }
}
