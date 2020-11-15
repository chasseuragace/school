import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolapp/screens/homepage/homepage.dart';
import 'package:schoolapp/screens/login/login_manager.dart';
import 'package:schoolapp/simple_utils/widgets.dart';

import '../../const.dart';
import 'custom_bottom_navigation.dart';



class HomePageWrapper extends StatefulWidget {

   @override
  _HomePageWrapperState createState() => _HomePageWrapperState();
}

class _HomePageWrapperState extends State<HomePageWrapper>
    with SingleTickerProviderStateMixin {
  AnimationController animController;
  Animation<double> scale;
  Animation<Offset> slide;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(keepPage: true);
    animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    animController.addListener(() {
      isTouchable.value = animController.status != AnimationStatus.completed;
    });
  }

  ValueNotifier<bool> isTouchable = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    initializeAnimations();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Stack(
        children: [
          //drawer background filter
          backgroundFilter(),
          //dashboard page
          AnimatedBuilder(
            animation: animController,
            builder: (c, child) {
              return drawerTransition(child);
            },
            child: Scaffold(
              appBar: buildAppBar(),
              body: GestureDetector(
                onHorizontalDragUpdate: drawerSwipeHandler,
                child: SafeArea(
                  child: Container(
                    height: height(context),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 1,
                          child: ValueListenableBuilder(
                            valueListenable: isTouchable,
                            builder: (BuildContext context,
                                bool isDashboardTouchable, Widget child) {
                              return Stack(
                                children: [
                                  child,
                                  if (!isDashboardTouchable) untouchableFilter()
                                ],
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: pageContent(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        CustomBottomNavigation(
                          navItems: {
                            "Home": Icons.home,
                            "Notification": Icons.notifications,
                            "Calendar": Icons.calendar_today,
                            "Profile": Icons.person,
                          },
                          onTabChange: (page) {
                            _pageController.jumpToPage(page);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget pageContent() {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              HomePage(),
              Container(
                color: Colors.red,
              ),
              Container(
                color: Colors.yellow,
              ),
              Container(
                color: Colors.orangeAccent,
              ),
            ],
          ),
        )
      ],
    );
  }

  Container untouchableFilter() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white70,
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
centerTitle: true,
     title: SizedBox(

       width:  (MediaQuery.of(context).size.width-50)*.8,
         child: Text("Very Long School name School Name",maxLines: 2,textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,style: Constants.title.copyWith(letterSpacing: 1,fontSize: 20),)),
      leading:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          IconButton(
            onPressed: () {
              animController.status == AnimationStatus.completed
                  ? animController.reverse()
                  : animController.forward();
            },
            icon: SizedBox(width: 22,height: 50,child: FittedBox(fit: BoxFit.contain, child: menu())),
          ),
        ],
      ),
    );
  }

  Widget backgroundFilter() {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      ListTile(
        onTap: () {
          Provider.of<LoginManger>(context,listen: false).logout(() => print("error logout"));
        },
        title: Text("Logout"),
      )
        ],
      ),
    );
  }

  double height(BuildContext context) {
    return MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
  }

  void drawerSwipeHandler(detail) {
    if (animController.status == AnimationStatus.completed &&
        detail.delta.dx < -10) animController.reverse();
  }

  Transform drawerTransition(Widget child) {
    return Transform.scale(
      scale: scale.value,
      child: Transform.translate(
          offset: slide.value,
          child: Material(
              color: Colors.white,
              elevation: slide.value.dx / 40,
              borderRadius: BorderRadius.circular(slide.value.dx / 15),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(slide.value.dx / 15),
                  child: child))),
    );
  }

  initializeAnimations() {
    slide = Tween<Offset>(
            end: Offset(MediaQuery.of(context).size.width * .65, 0),
            begin: Offset.zero)
        .animate(
            CurvedAnimation(parent: animController, curve: Curves.easeInExpo));
    scale = Tween<double>(end: .8, begin: 1.0).animate(
        CurvedAnimation(parent: animController, curve: Curves.easeOutExpo));
  }


}
