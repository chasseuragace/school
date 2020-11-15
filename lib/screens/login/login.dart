import 'package:flutter/material.dart';

import 'package:schoolapp/simple_utils/widgets.dart';
import '../../const.dart';
import 'login_card/login_card.dart';


class LogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
         FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title:     Text(
          "Login",
          style:
          Constants.title.copyWith(fontSize: 18, letterSpacing: 1),
        ),centerTitle: true,elevation: 0,backgroundColor: Colors.transparent,actions: [
          IconButton(
            onPressed: () {
               FocusScope.of(context).unfocus();
              showTermsAndPolicy(context);
            },
            icon: Icon(
              Icons.info,
              color: Colors.grey,
            ),
          ),
        ],),
          backgroundColor: Color(0xfff8f8f8),
          body: SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom-56,
                child: Column(
                  children: [
                    Expanded(child: Transform.scale(scale: .859,child: CardLogin()))
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void showLoginFailMessage(context, manager) {
    Future.delayed(Duration(seconds: 1), () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(manager.errorText ?? Constants.defaultloginError)));
    });
  }
}
