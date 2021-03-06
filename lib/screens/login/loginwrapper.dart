import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolapp/screens/login/login.dart';
import 'package:schoolapp/screens/navigation_wrapper/navigation_wrapper.dart';

import 'login_manager.dart';

class LoginWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var loginManager = Provider.of<LoginManger>(context);
    return ValueListenableBuilder(
      valueListenable: loginManager.currentState,
      builder: (BuildContext context, LoginStates currentState, Widget child) {
        return currentState == LoginStates.loggedIn
            ? HomePageWrapper()
            : LogIn();
      },
    );
  }
}
