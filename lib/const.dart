import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  static String appName ="School Gaffer";
  static String passwordValidationError ="Password must contain at least 6 characters.";
  static String phoneValidationError ="Phone number must have exactly 10 digits ";
  static TextStyle title =const TextStyle(
      inherit: false,
      color: Color(0x8a000000),
      fontFamily: "Roboto",
      fontSize: 28.0,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none);

  static Color lightPrimary = Color(0xffffffff);
  //static Color lightPrimary = Colors.red;
  static Color darkPrimary = Colors.black;
  static Color lightAccent = Color(0xff38ef7d);
  static Color darkAccent = Color(0xff11998e);
  static Color lightBG = Color(0xffffffff);
  static Color darkBG = Colors.black;
  static String  defaultloginError =  'Woopsie! Login Failed, please retry in a minute or so.';

  static ThemeData lightTheme = ThemeData(
    fontFamily: GoogleFonts.roboto().fontFamily,
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    textSelectionTheme: TextSelectionThemeData(cursorColor: lightAccent),
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        headline6: TextStyle(
          color: darkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
//      iconTheme: IconThemeData(
//        color: lightAccent,
//      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    fontFamily: GoogleFonts.roboto().fontFamily,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    textSelectionTheme: TextSelectionThemeData(cursorColor: darkAccent),
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        headline6: TextStyle(
          color: lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
//      iconTheme: IconThemeData(
//        color: darkAccent,
//      ),
    ),
  );

}
