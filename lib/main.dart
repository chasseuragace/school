import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolapp/const.dart';
import 'package:schoolapp/screens/internal_pages/articles/articles.dart';
import 'package:schoolapp/screens/internal_pages/attendance/attendance.dart';
import 'package:schoolapp/screens/internal_pages/bus_details/bus_details.dart';
import 'package:schoolapp/screens/internal_pages/class_routine/class_routine.dart';
import 'package:schoolapp/screens/internal_pages/due_details/due_details.dart';
import 'package:schoolapp/screens/internal_pages/events/events.dart';
import 'package:schoolapp/screens/internal_pages/exam_routine/exam_routine.dart';
import 'package:schoolapp/screens/internal_pages/homework/homework.dart';
import 'package:schoolapp/screens/internal_pages/library/library.dart';
import 'package:schoolapp/screens/internal_pages/project_work/project_work.dart';
import 'package:schoolapp/screens/internal_pages/results/exam_results.dart';
import 'package:schoolapp/screens/internal_pages/school_details/school_details.dart';
import 'package:schoolapp/screens/internal_pages/subjects/subjects.dart';
import 'package:schoolapp/screens/internal_pages/suggestion/sgegstion.dart';
import 'package:schoolapp/screens/intro/walkthrough.dart';
import 'package:schoolapp/screens/login/login_manager.dart';
import 'package:schoolapp/screens/login/loginwrapper.dart';
import 'package:schoolapp/services/shared_prefrernces/shared_pref.dart';
import 'package:schoolapp/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        /*Provider(
          create: (_) => ServiceManager(),
        ),*/
        Provider(
          create: (_) => LoginManger(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (BuildContext context, ThemeProvider appProvider, Widget child) {
        return MaterialApp(
          key: appProvider.key,
          debugShowCheckedModeBanner: false,
          navigatorKey: appProvider.navigatorKey,
          title: Constants.appName,
          theme: appProvider.theme,
          darkTheme: Constants.darkTheme,
          home:
          // TestWidget()
          !LocalStorage.shouldSkipIntro
              ? Walkthrough()
              : LoginWrapper(),
          routes: {
            Attendance.tag: (context) => Attendance(),
            ClassRoutine.tag: (context) => ClassRoutine(),
            ExamRoutine.tag: (context) => ExamRoutine(),
            ExamResults.tag: (context) => ExamResults(),
            Homework.tag: (context) => Homework(),
            Suggestion.tag: (context) => Suggestion(),
            Subjects.tag: (context) => Subjects(),
            Articles.tag: (context) => Articles(),
            Library.tag: (context) => Library(),
            Events.tag: (context) => Events(),
            SchoolDetails.tag: (context) => SchoolDetails(),
            ProjectWork.tag: (context) => ProjectWork(),
            DueDetails.tag: (context) => DueDetails(),
            BusDetails.tag: (context) => BusDetails(),
          },
        );
      },
    );
  }
}