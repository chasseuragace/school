import 'package:flutter/material.dart';
import 'package:schoolapp/screens/internal_pages/attendance/attendance.dart';
import 'package:schoolapp/screens/internal_pages/class_routine/class_routine.dart';
import 'package:schoolapp/screens/internal_pages/exam_routine/exam_routine.dart';
import 'package:schoolapp/screens/internal_pages/results/exam_results.dart';

import 'const.dart';

const schoolName ="Shree Janata Purbanchal Madhyamik Bidhalaya";
const schoolLocationx ="Sallahghari-6, Bthaktapur";
const studentName = "Thomas Shelby";
const studentImage = "assets/user.png";
const schoolLogo= "assets/dofo.png";
const studentDogTagAttributes =  {
  "Class": "SIxteen",
  "Section": "Stone Cold",
  "DOB": "Jan 27, 2008",
  "Rank": "12",
};
const tiles = {
  "Attendance": Attendance.tag,
  "Class Routine": ClassRoutine.tag,
  "Exam Routine": ExamRoutine.tag,
  "Daily Homework": "homework",
  "Results": ExamResults.tag,
  "Subjects": "subjects",
  "Project Work": "project",
  "Library": "library",
  "Articles": "article",
  "Events": "events",
  "Due Dates": "due",
  "Suggestions": "suggestions",
  "School Details": "about",
  "Language ": "language",

};

noNotifications(context, {bool inDrawer=false})=>    Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Image.asset("assets/emptyNotification.png",height:  MediaQuery.of(context).size.height*.3,),
    Text( inDrawer ?"You'll see recent notifications here!" : "It's all quiet here!",style: Constants.title.copyWith(fontSize: 24,color: Colors.grey[400]),textAlign: TextAlign.center,)
  ],
);