import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolapp/const.dart';
import 'package:schoolapp/screens/intro/walkthrough.dart';
import 'package:schoolapp/screens/login/login_manager.dart';
import 'package:schoolapp/screens/login/loginwrapper.dart';
import 'package:schoolapp/services/shared_prefrernces/shared_pref.dart';
import 'package:schoolapp/simple_utils/ui_modifiers.dart';
import 'package:schoolapp/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        /*Provider(
          create: (_) => ServiceManager(),
        ),*/
        Provider(
          create: (_) => LoginManger(),
        )
      ],
      child: ScrollConfiguration(behavior: NoGlow(),child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (BuildContext context, ThemeProvider appProvider, Widget child) {
        return MaterialApp(
            key: appProvider.key,
            debugShowCheckedModeBanner: false,
            navigatorKey: appProvider.navigatorKey,
            title: Constants.appName,
            theme: appProvider.theme,
            darkTheme: Constants.darkTheme,
            home:
            // TestWidget()
            !LocalStorage.shouldSkipIntro
                ? Walkthrough()
                : LoginWrapper());
      },
    );
  }
}