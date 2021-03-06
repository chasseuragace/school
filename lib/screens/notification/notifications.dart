import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schoolapp/const.dart';
import 'package:schoolapp/screens/navigation_wrapper/material_notification.dart';
import 'package:schoolapp/screens/notification/notification_manager.dart';
import 'package:schoolapp/simple_utils/widgets.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>   with AutomaticKeepAliveClientMixin  {
final  ValueNotifier<bool> switchDisplay =ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(

      body: Padding(
        padding:  Constants.padding,
        child: Column(
          children: [
            Row(
              children: [
                TweenAnimationBuilder(
                  key: UniqueKey(),
                  curve: Curves.elasticOut,
                  duration: Duration(milliseconds: 900),
                  tween: Tween<double>(begin: -(22/7)/180*25,end: (22/7)/180*0),
                  builder: (BuildContext context, double value, Widget child) {
                   return Transform.rotate(
                      angle: value,
                      child: child,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:8.0),
                    child: applyShade(child: Icon(Icons.notifications,color: Colors.white,)),
                  ),
                ),
                GestureDetector(onTap: (){
                  switchDisplay.value=!switchDisplay.value;
                },child: Text("Notifications",style: Constants.title ,)),
              ],
            ),
            SizedBox(height: 6,),
            Expanded(flex: 1,
            child:ValueListenableBuilder<bool>(
              valueListenable: switchDisplay,
              builder: (_, snapshot,child) {
                      return snapshot
                          ? //noNotifications(context):

                          notificationManager.manage(
                              loaded: (List<Schoolnotifications>
                                      notifications) =>
                                  ListView.separated(
                                    itemCount: notifications.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var data = notifications[index];
                                      return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 3.0,
                                          ),
                                          child: MaterialNotification(
                                            focused: true,
                                            content: data.notification,
                                            title: data.notificationTitle,
                                          ));
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox(
                                        height: 4,
                                      );
                                    },
                                  ),
                              loading: () => Text('ing'),
                              error: (err) => Text('err'))
                          : ListView.separated(
                              itemCount: 18,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 3.0,
                                  ),
                                  child: index == 0
                                      ? MaterialNotification(
                                          focused: true,
                                          content:
                                              "Dear Parents/ Guardians,Greetings! "
                                              "It is hereby notified that the school management is "
                                              "conducting a Parents' Meeting of Grade 9 and 10 on 27th Baishakh,"
                                              " 2075, Thursday between 4:00 pm - 4:30 pm and of Grade 4,5 and 6 "
                                              "on 29th Baishakh, 2075, Saturday between 8:00 am - to 9:00 am.We humbly "
                                              "request our respected parents and guardians to attend the meeting compulsorily "
                                              "for student's progress.\nThank you for your kind cooperation.",
                                          title:
                                              "Parents' Meeting on 27th Baishakh",
                                        )
                                      : index % 2 == 0
                                          ? MaterialNotification(
                                              focused: true,
                                              title:
                                                  "Wear Your Mask (Face Covering).",
                                              content:
                                                  "Scientific evidence shows that wearing a "
                                                  "face covering significantly reduces Covid-19 "
                                                  "infections, offering protection against both "
                                                  "respiratory droplets and airborne transmission. "
                                                  "The CDC recommends that schools enforce consistent"
                                                  " masking policies for both students and staff.",
                                            )
                                          : index % 3 == 0
                                              ? MaterialNotification(
                                                  focused: true,
                                                  title:
                                                      "Dear Parents This Is To Inform You That, School Will Reopen From Tomorrow",
                                                  image: ["s"],
                                                  content:
                                                      "The school shall reopen from Monday,12th "
                                                      "January 2015.Regular timings will be followed.Further instructions of"
                                                      " exams and report card will be given on reopening",
                                                )
                                              : MaterialNotification(
                                                  focused: true,
                                                  title:
                                                      "Painting competition Writing Skill",
                                                  image: ["D", "sd"],
                                                  content:
                                                      "All students of this school are informed that our school is"
                                                      " going to organise a painting competition on 10 March in the school "
                "campus at 10 A.M to 12 A.M. "
                "Entry fees for this competition is R.S. 100 per competitor"
                " and registration form is available in Principal office.",
                ) ,
                );
                }, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 4,); },

                );
              }
            )
            )

          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
