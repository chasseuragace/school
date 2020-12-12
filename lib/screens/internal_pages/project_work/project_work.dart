import 'package:flutter/material.dart';
import 'package:schoolapp/screens/internal_pages/articles/articles_viewer.dart';
import 'package:schoolapp/screens/internal_pages/custom_app_bar.dart';
import 'package:schoolapp/screens/navigation_wrapper/material_notification.dart';

class ProjectWork extends StatelessWidget {
  static const String tag = "project";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(tag: tag, title: "Project Work"),
            Expanded(
              child: ListView.separated(
                itemCount: 18,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 3.0,
                    ),
                    child: index == 0
                        ? MaterialNotification.deadline(
                            focused: true,
                            useHero: '$index',
                            compact: true,
                            onTap: (_) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (c) => ArticleViewer(
                                        child: MaterialNotification.deadline(
                                          asArticle: true,
                                          id: index,
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
                                        ),
                                      )));
                            },
                            content: "Dear Parents/ Guardians,Greetings! "
                                "It is hereby notified that the school management is "
                                "conducting a Parents' Meeting of Grade 9 and 10 on 27th Baishakh,"
                                " 2075, Thursday between 4:00 pm - 4:30 pm and of Grade 4,5 and 6 "
                                "on 29th Baishakh, 2075, Saturday between 8:00 am - to 9:00 am.We humbly "
                                "request our respected parents and guardians to attend the meeting compulsorily "
                                "for student's progress.\nThank you for your kind cooperation.",
                            title: "Parents' Meeting on 27th Baishakh",
                          )
                        : index % 2 == 0
                            ? MaterialNotification.deadline(
                                focused: true,
                                compact: true,
                                useHero: '$index',
                                onTap: (_) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (c) => ArticleViewer(
                                            child:
                                                MaterialNotification.deadline(
                                              asArticle: true,
                                              id: index,
                                              title:
                                                  "Wear Your Mask (Face Covering).",
                                              content:
                                                  "Scientific evidence shows that wearing a "
                                                  "face covering significantly reduces Covid-19 "
                                                  "infections, offering protection against both "
                                                  "respiratory droplets and airborne transmission. "
                                                  "The CDC recommends that schools enforce consistent"
                                                  " masking policies for both students and staff.",
                                            ),
                                          )));
                                },
                                title: "Wear Your Mask (Face Covering).",
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
                                    compact: true,
                                    useHero: '$index',
                                    onTap: (_) {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (c) => ArticleViewer(
                                                    child: MaterialNotification
                                                        .deadline(
                                                      asArticle: true,
                                                      id: index,
                                                      title:
                                                          "Dear Parents This Is To Inform You That, School Will Reopen From Tomorrow",
                                                      image: ["s"],
                                                      content:
                                                          "The school shall reopen from Monday,12th "
                                                          "January 2015.Regular timings will be followed.Further instructions of"
                                                          " exams and report card will be given on reopening",
                                                    ),
                                                  )));
                                    },
                                    title:
                                        "Dear Parents This Is To Inform You That, School Will Reopen From Tomorrow",
                                    image: ["s"],
                                    content:
                                        "The school shall reopen from Monday,12th "
                                        "January 2015.Regular timings will be followed.Further instructions of"
                                        " exams and report card will be given on reopening",
                                  )
                                : MaterialNotification.deadline(
                                    focused: true,
                                    compact: true,
                                    useHero: '$index',
                                    onTap: (_) {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (c) => ArticleViewer(
                                                    child: MaterialNotification
                                                        .deadline(
                                                      id: index,
                                                      asArticle: true,
                                                      title:
                                                          "Painting competition Writing Skill",
                                                      image: ["D", "sd"],
                                                      content: "All students of this school are informed that our school is"
                                                              " going to organise a painting competition on 10 March in the school "
                                                              "campus at 10 A.M to 12 A.M. "
                                                              "Entry fees for this competition is R.S. 100 per competitor"
                                                              " and registration form is available in Principal office." *
                                                          7,
                                                    ),
                                                  )));
                                    },
                                    title: "Painting competition Writing Skill",
                                    image: ["D", "sd"],
                                    content:
                                        "All students of this school are informed that our school is"
                                        " going to organise a painting competition on 10 March in the school "
                                        "campus at 10 A.M to 12 A.M. "
                                        "Entry fees for this competition is R.S. 100 per competitor"
                                        " and registration form is available in Principal office.",
                                  ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 4,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
