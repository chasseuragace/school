import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:schoolapp/screens/forgotPassword/forgot_password.dart';
import 'package:schoolapp/screens/login/login_manager.dart';
import 'package:schoolapp/simple_utils/widgets.dart';

import '../../../const.dart';

class CardLogin extends StatefulWidget {
  @override
  _CardLoginState createState() => _CardLoginState();
}

class _CardLoginState extends State<CardLogin> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _un;
  TextEditingController _pw;
  FocusNode _pwFocus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _un = TextEditingController(text: "");
    _pw = TextEditingController(text: "");
    _pwFocus = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _un.dispose();
    _pw.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _manager = Provider.of<LoginManger>(context);
    return Material(
      elevation: 2,
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Form(
          key: _formKey,
          child: MediaQuery.of(context).orientation == Orientation.portrait
              ? Column(
                  children: [
                    loginLogo(),
                    Expanded(flex: 4, child: loginContent(context, _manager))
                  ],
                )
              : Row(
                  children: [
                    Expanded(flex: 2, child: loginLogo()),
                    Expanded(flex: 3, child: loginContent(context, _manager))
                  ],
                ),
        ),
      ),
    );
  }

  Column loginContent(BuildContext context, LoginManger _manager) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Expanded(
          flex: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (s) {
                    return s.isValidEmail()
                        ? null
                        : "${s.trim().length > 0 ? s + " is not a" : "Please enter a"} valid email address.";
                  },
                  controller: _un,
                  onFieldSubmitted: (v) {
                    _pwFocus.requestFocus();
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: Colors.green)),
                    hintText: "Email Address",
                  ),
                ),
              ),
              _PasswordFieldWidget(controller: _pw, node: _pwFocus),
              OpenContainer(
                closedElevation: 0,
                openBuilder: (BuildContext context,
                    void Function({Object returnValue}) action) {
                  return Center(child: ForgotPassword());
                },
                closedBuilder: (BuildContext context, void Function() action) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          height: 20,
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ));
                },
              ),
              ValueListenableBuilder<LoginStates>(
                valueListenable: _manager.currentState,
                builder: (con, val, _) {
                  if (val == LoginStates.error)
                    showLoginFailMessage(context, _manager);
                  return AnimatedSwitcher(
                    child: val == LoginStates.loading
                        ? SizedBox(
                            key: ValueKey("1"),
                            height: 50,
                            child: Center(child: CircularProgressIndicator()))
                        : SizedBox(
                            /* width:
                                        MediaQuery.of(context).size.width * .554,*/
                            key: ValueKey("2"),
                            height: 50,
                            child: appButton(
                              text: "Login",
                              onTap: () async {
                                FocusScope.of(context).unfocus();
                                if (_formKey.currentState.validate())
                                  _manager.login(
                                      username: _un.text, password: _pw.text);
                              },
                            )),
                    duration: Duration(milliseconds: 400),
                  );
                },
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget loginLogo() {
    return Column(
      children: [
        Image.asset(
          "assets/intro2.png",
          height: MediaQuery.of(context).orientation == Orientation.landscape
              ? null
              : MediaQuery.of(context).size.height * .35,
          fit: BoxFit.contain,
        ),
        Text(
          Constants.appName,
          style: Constants.title.copyWith(fontSize: 25, letterSpacing: 1),
        ),
      ],
    );
  }

  void showLoginFailMessage(context, manager) {
    Future.delayed(Duration(seconds: 1), () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(manager.errorText ?? Constants.defaultloginError)));
    });
  }
}

class _PasswordFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode node;

  const _PasswordFieldWidget({Key key, this.controller, this.node})
      : super(key: key);

  @override
  _PasswordFieldWidgetState createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<_PasswordFieldWidget> {
  bool hidden = true;
  bool showingEye = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Stack(
        children: [
          TextFormField(
            onChanged: (v) {
              if (!showingEye && v.trim().length > 1)
                setState(() {
                  showingEye = true;
                });
              else if (showingEye && v.trim().length < 1)
                setState(() {
                  showingEye = false;
                });
            },
            focusNode: widget.node,
            controller: widget.controller,
            obscureText: hidden,
            validator: (s) {
              if (s.trim().length < 6)
                return Constants.passwordValidationError;
              else
                return null;
            },
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.grey,
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.green)),
              hintText: "Password",
            ),
          ),
          if (widget.controller.text.trim().length > 0)
            Positioned(
              top: 6,
              right: 4,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      hidden = !hidden;
                    });
                  },
                  child: Material(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white.withOpacity(.02),
                      child: SizedBox(
                          height: 44,
                          width: 50,
                          child: Icon(
                            hidden
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            size: 20,
                          )))),
            ),
        ],
      ),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
