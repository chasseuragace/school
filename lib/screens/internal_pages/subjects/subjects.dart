import 'package:flutter/material.dart';
import 'package:schoolapp/screens/internal_pages/custom_app_bar.dart';

class Subjects extends StatelessWidget {
  static const String tag = "subjects";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(tag: tag, title: "Subjects"),
            Expanded(
              child: ListView(
                children: [
                  ...generateSubjects().keys.map((e) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 6),
                        child: ListTile(
                          title: Text(e),
                          subtitle: Text(generateSubjects()[e]),
                          onTap: () {},
                          tileColor: Colors.grey[200],
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Map<String, dynamic> generateSubjects() {
  var map = {
    "Math": "Monkika Sapkota",
    "English": "Suresh  Chand Sitaula",
    "Socila": "P.K Bhattarai",
    "Nepali": "Dhurba Lamichhane",
  };
  return map;
}
