import 'package:flutter/material.dart';
import 'package:schoolapp/const.dart';
import 'package:url_launcher/url_launcher.dart';

Widget makeScaleTween({Widget child, context}) {
  return TweenAnimationBuilder(duration: const Duration(milliseconds: 400),
    child: child,
    curve: Curves.easeInOut,
    tween: Tween<double>(begin: .8,end: 1),
    builder: (BuildContext context, double value, Widget child) {
      return Transform.scale(
        child: child,
        scale: value,
      );
    },);
}

Widget makeSlideTween({Widget child, context}) {
  return TweenAnimationBuilder(duration: const Duration(milliseconds: 300),
    child: child,
    curve: Curves.easeInOut,
    tween: Tween<double>(begin:  MediaQuery.of(context).size.width/4,end: 1),
    builder: (BuildContext context, double value, Widget child) {
      return Transform.translate(
        child: child,
        offset: Offset(value,0),
      );
    },);
}

showSimpleAlert(BuildContext context,
    {String positiveText = "OK",
      String negativeText = "Cancel",
      String title = "",
      String message = "",
      bool dismissible = true}) async {
  Widget okButton = FlatButton(
    child: Text(positiveText),
    onPressed: () {
      Navigator.of(context).pop(true);
    },
  );
  Widget cancelButton = FlatButton(
    child: Text(negativeText,style: TextStyle(color: Colors.grey),),
    onPressed: () {
      Navigator.of(context).pop(false);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    elevation: 0,
    title: Text(title),
    content: Text(message),
    actions: [
      cancelButton,
      okButton,
    ],
  );

  // show the dialog
  return showDialog(
    barrierDismissible: dismissible,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showTermsAndPolicy(BuildContext context,
    ) async {

  bool dismissible = true;
/*
  String positiveText = "Close";
 Widget okButton = FlatButton(
    child: Text(positiveText),
    onPressed: () {
      Navigator.of(context).pop(true);
    },
  );*/


  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    elevation: 0,
    title: Center(child: Text(Constants.appName)),
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(onPressed: ()async {
          const url = 'https://flutter.dev';
          if (await canLaunch(url)) {
          await launch(url);
          } else {
          throw 'Could not launch $url';
          }
        },
        child: Text("Terms And Conditions")),
        TextButton(onPressed: ()async {
          const url = 'https://flutter.dev';
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        },
            child: Text("Privacy Policy")),
      ],
    ),

  );

  // show the dialog
  return showDialog(
    barrierDismissible: dismissible,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}



Widget menu() {
  var height = 12.0;
  var width = 80.0;
  return Center(
      child: Container(
        width: width,
        height: height * 3 + 15.0,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: width * .6,
                height: height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12), color: Colors.black),
              ),
            ),
            Center(
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12), color: Colors.black),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: width * .6,
                height: height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12), color: Colors.black),
              ),
            ),
          ],
        ),
      ));
}