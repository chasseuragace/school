import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolapp/screens/homepage/homepage.dart';
import 'package:schoolapp/screens/login/login_manager.dart';
import 'package:schoolapp/simple_utils/widgets.dart';
import 'package:schoolapp/simple_utils/date_formatter.dart';
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
  String name = "Shree Janata Madhyamik Bidhalaya";

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
          drawer(),
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
                          selectedItemColor: Colors.white,
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
      /*  title: SizedBox(
          width: (MediaQuery.of(context).size.width - 50) * .8,
          child: Text(
            "Very Long School name School Name",
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: Constants.title.copyWith(letterSpacing: 1, fontSize: 20),
          )),*/
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              animController.status == AnimationStatus.completed
                  ? animController.reverse()
                  : animController.forward();
            },
            icon: SizedBox(
                width: 22,
                height: 50,
                child: FittedBox(fit: BoxFit.contain, child: menu())),
          ),
        ],
      ),
    );
  }

  Widget drawer() {
    var drawerattribs = {"Phone": Icons.phone, "Address": Icons.location_on};
    return Material(
      child: SafeArea(
        child: Container(
          color: Colors.grey[200],
          width: MediaQuery.of(context).size.width,
          child: ValueListenableBuilder(
            builder: (BuildContext context, value, Widget child) {
             return value? SizedBox.expand() : makeScaleTween(
               duration:400,
               child: child,
               curve:Curves.easeInCubic
             );
            },
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      //color: Colors.grey,
                      width: MediaQuery.of(context).size.width * .6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start  ,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey,
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
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Shree Janata Madhyamik Bidhalaya",
                                      textAlign: TextAlign.center,
                                      style: Constants.titleWhite
                                          .copyWith(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 5),
                            child: Text(
                              DateTime.now().standard(),
                              style: Constants.title,
                            ),
                          ),
                          Expanded(
                            child:!true? Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ListTile(
                                  title: Text("No new notice"),
                                  subtitle: Text("General notice will appear here"),

                                ),
                                Text(DateTime.now().standard(),style: TextStyle(fontSize: 12,color: Colors.grey),)
                              ],
                            ):  ListView.builder(
                              itemCount: 8,
                              padding: EdgeInsets.zero,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom:8.0),
                                  child: Dismissible(

                                    key: UniqueKey(),
                                    onDismissed: (dir){
                                      //todo mark as read , put user id in notification read array, firebse
                                    },
                                    child: Material(
                                      color: Colors.white,
                                      child:Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          ListTile(

                                            /* onTap: (){
                                                //todo open notification alert box if has body
                                              },*/
                                            title: Text("No new notice"),
                                            subtitle:  Text("Dear Parents and Students, Greetings of the day. I hope the message finds you "
                                                "in good health and among family members amidst the Lockdown. Let's be ...",textAlign: TextAlign.justify,),

                                          ),
                                          Text(DateTime.now().standard(),style: TextStyle(fontSize: 12,color: Colors.grey),)
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  ListTile(
                    onTap: () {
                      Provider.of<LoginManger>(context, listen: false)
                          .logout(() => print("error logout"));
                    },
                    title: Center(child: Text("Logout")),
                  )
                ],
              ),
            ), valueListenable: isTouchable,
          ),
        ),
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
