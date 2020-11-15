import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:introduction_screen/introduction_screen.dart';

import 'package:schoolapp/screens/login/loginwrapper.dart';
import 'package:schoolapp/services/shared_prefrernces/shared_pref.dart';
import 'package:schoolapp/simple_utils/widgets.dart';

class Walkthrough extends StatefulWidget {
  @override
  _WalkthroughState createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough>  {


  List pageInfos = [
    {
      "title": "Get latest news and updates",
      "body": "Get notified about all the latest news, updates,"
          " school events and information on teacher parents meeting",
      "img": "assets/intro1.png",
    },
    {
      "title": "Keep up with your child",
      "body": "Get access to your child's attendance, homework,"
          " class and exam routine, "
          "results, bus details and much more,"
          " all under your finger tips ",
      "img": "assets/intro2.png",
    },
    {
      "title": "Easy access no matter where you are",
      "body":
          "You'll be able to access all the updates and information even if your are miles away from your child's school",
      "img": "assets/intro3.png",
    },
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }
  @override
  Widget build(BuildContext context) {

    List<PageViewModel> pages = [
      for (int i = 0; i < pageInfos.length; i++) _buildPageModel(pageInfos[i])
    ];

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: IntroductionScreen(
            dotsDecorator: DotsDecorator(
                color: Theme.of(context).accentColor.withOpacity(.2),
                activeColor: Theme.of(context).accentColor),
            pages: pages,
            onDone: _onDone,
            onSkip: _onDone,
            showSkipButton: true,
            skip: Text("Skip"),
            next: Text(
              "Next",
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            done:
            Text(
              "Done",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).accentColor,
              ),
            ),

          ),
        ),
      ),
    );
  }

  _buildPageModel(Map item) {
    return PageViewModel(
      title: item['title'],
      body: item['body'],
      image: makeScaleTween(
        child: Image.asset(
          item['img'],
          height: 185.0,
        ),
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w600,
        ),
        bodyTextStyle: TextStyle(fontSize: 15.0),
        pageColor: Theme.of(context).primaryColor,
      ),
    );
  }

  void _onDone() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    LocalStorage.skipIntro();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return LoginWrapper();
        },
      ),
    );
  }
}
