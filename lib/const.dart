import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  static EdgeInsets padding= EdgeInsets.symmetric(horizontal:8.0);
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
  static TextStyle titleWhite =const TextStyle(
      inherit: false,
      color: Colors.white,
      fontFamily: "Roboto",
      fontSize: 28.0,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none);

  static Color lightPrimary = Color(0xffffffff);
  //static Color lightPrimary = Colors.red;
  static Color darkPrimary = Colors.black;
  static   List<Color> get tileGradient => [lightAccent,lightAccentComplimentary];
  static Color lightAccent = Color(0xff35f481);
  static Color lightAccentComplimentary = Color(0xff14c9ca);
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

  static var months = {
    "1": "Jan",
    "2": "Feb",
    "3": "March",
    "4": "April",
    "5": "May",
    "6": "June",
    "7": "July",
    "8": "Aug",
    "9": "Sep",
    "10": "Oct",
    "11": "Nov",
    "12": "Dec",
  };
  static var days = {
    "1": "Sunday",
    "2": "Monday",
    "3": "Tuesday",
    "4": "Wednesday",
    "5": "Thursday",
    "6": "Friday",
    "7": "Saturday",

  };
}
