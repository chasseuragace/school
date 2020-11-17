import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schoolapp/const.dart';
import 'package:schoolapp/screens/navigation_wrapper/material_notification.dart';
import 'package:schoolapp/simple_utils/widgets.dart';

class NotificationsPage extends StatelessWidget {
  ValueNotifier<bool> switchDisplay =ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
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
                return snapshot? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/emptyNotification.png",height:  MediaQuery.of(context).size.height*.3,),
                    Text("It's all quiet here!",style: Constants.title.copyWith(fontSize: 24,color: Colors.grey[400]),)
                  ],
                ):ListView.builder(
                itemCount: 18,
                itemBuilder: (BuildContext context, int index) {
                return Padding(
                padding: const EdgeInsets.symmetric(vertical:3.0),
                child: index%2==0?MaterialNotification(
                title: "Wear Your Mask (Face Covering).",
                content: "Scientific evidence shows that wearing a "
                "face covering significantly reduces Covid-19 "
                "infections, offering protection against both "
                "respiratory droplets and airborne transmission. "
                "The CDC recommends that schools enforce consistent"
                " masking policies for both students and staff.",
                ): index%3==0?MaterialNotification(
                title: "Dear Parents This Is To Inform You That, School Will Reopen From Tomorrow",
                image: ["s"],
                content: "The school shall reopen from Monday,12th "
                    "January 2015.Regular timings will be followed.Further instructions of"
                    " exams and report card will be given on reopening",
                ) :MaterialNotification(
                title: "Painting competition Writing Skill",
                image: ["D","sd"],
                content: "All students of this school are informed that our school is"
                " going to organise a painting competition on 10 March in the school "
                "campus at 10 A.M to 12 A.M. "
                "Entry fees for this competition is R.S. 100 per competitor"
                " and registration form is available in Principal office.",
                ) ,
                );
                },

                );
              }
            )
            )

          ],
        ),
      ),
    );
  }
}
