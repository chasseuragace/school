import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:schoolapp/const.dart';
import 'package:schoolapp/screens/internal_pages/custom_app_bar.dart';
import 'package:schoolapp/screens/internal_pages/library/library_controller.dart';
import 'package:schoolapp/simple_utils/date_formatter.dart';
import 'package:schoolapp/simple_utils/widgets.dart';

class Library extends StatelessWidget {
  static const String tag = "library";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(tag: tag, title: "Library"),
            libraryManager.mamage(
                error: (e) => Text('error'),
                loaded: (books) => Expanded(
                      child: ListView.builder(
                        itemCount: books.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 6),
                            child: ListTile(
                              tileColor: Constants.tilesColor,
                              leading: applyShade(
                                  child: Image.asset(
                                'assets/library.png',
                                color: Colors.white,
                              )),
                              title: Text(books[index].bookName),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Issued on: ${books[index].dateOfBorrow}"),
                                  Text(
                                      "Submit by: ${books[index].submissionDate}"),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )),
          ],
        ),
      ),
    );
  }
}

Map<String, dynamic> generateBooks() {
  var map = {
    '2550': {
      "name": 'the laws of Thermodynamics',
      "issuedOn": NepaliDateTime.now().standard(),
    },
    '23': {
      "name": 'History of barbarians',
      "issuedOn": NepaliDateTime.now().standard(),
    },
    '45': {
      "name": 'The big bang theory',
      "issuedOn": NepaliDateTime.now().standard(),
    },
    '67': {
      "name": 'Veda-I',
      "issuedOn": NepaliDateTime.now().standard(),
    },
  };
  return map;
}
