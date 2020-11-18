import 'package:flutter/material.dart';
import 'package:schoolapp/screens/navigation_wrapper/material_notification.dart';
import 'package:provider/provider.dart';
import 'package:schoolapp/screens/login/login_manager.dart';
import 'package:schoolapp/simple_utils/date_formatter.dart';

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: CircleAvatar(
                              radius: 35,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            name,
                            textAlign: TextAlign.center,
                            style: Constants.titleWhite.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
                  child: Text(
                    DateTime.now().standard(),
                    style: Constants.title,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 4),
                  child: Text("Recent Updates",style: Constants.title.copyWith(fontSize: 14),),
                ),
                Expanded(
                  child: true
                      ?  ListView(
                    children: [

                      MaterialNotification(date: '',signedBy: '',
                        compact: true,title: "No notifications yet !",
                        content: "General notifications will appear here.",),
                    /*  Center(child: Text("Empty!",
                        style: Constants.title.copyWith(fontSize: 16,color: Colors.grey[300]),)),*/
                    ],
                  )
                      : ListView.builder(
                          itemCount: 8,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all( 4.0),
                              child: Dismissible(
                                key: UniqueKey(),
                                onDismissed: (dir) {
                                  //todo mark as read , put user id in notification read array, firebse
                                },
                                child: MaterialNotification(compact: true,),
                              ),
                            );
                          },
                        ),
                ),
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
