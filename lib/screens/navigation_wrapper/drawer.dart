import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:schoolapp/screens/login/login_manager.dart';
import 'package:schoolapp/screens/navigation_wrapper/material_notification.dart';
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
                schoolBakgroundNameAndLogo(),
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
                  padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 4),
                  child: Text("Recent Updates",style: Constants.title.copyWith(fontSize: 14),),
                ),
                Expanded(
                  child: false
                      ?  FittedBox(
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                   child:noNotifications(context,inDrawer: true)




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
                                child: MaterialNotification(compact: true,title: "Holiday on Sunday",
                                  content: "Dear parents, this is to notify : the school"
                                    " remains closed on Baishakh 2nd 2077 due to unexpected strike.",),
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

  Padding schoolBakgroundNameAndLogo() {
    return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(12),

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/intro1.png",),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken))
                      ),
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
                                backgroundColor: Colors.white70,
                                child: Image.asset(schoolLogo,fit: BoxFit.contain,),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "$name",
                              textAlign: TextAlign.center,
                              style: Constants.titleWhite.copyWith(fontSize: 16),
                            ),
                            Text(
                              "$schoolLocationx",
                              textAlign: TextAlign.center,
                              style: Constants.titleWhite.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
  }
}
