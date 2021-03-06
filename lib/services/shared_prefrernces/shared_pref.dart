import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static init() async {
    sp ??= await SharedPreferences.getInstance();
  }

  static SharedPreferences sp;

  static skipIntro({bool shouldSip = true}) {
    sp.setBool("intro", shouldSip);
  }

  static bool get shouldSkipIntro => sp.getBool('intro') ?? false;

  static setLogin({bool setLoginTo = true}) {
    sp.setBool("login", setLoginTo);
  }

  static bool get isLoggedIn => sp.getBool('login') ?? false;

  static void setAccessToken(String accessToken) {
    sp.setString('accessToken', accessToken);
  }

  static String get accessToken => sp.getString('accessToken');

  static setProfileData(Map<String, dynamic> profileData) async {
    return sp.setString('profileData', jsonEncode(profileData['profile']));
  }

  static setNotificationsData(Map<String, dynamic> notificationData) async {
    return sp.setString(
        'notifications', jsonEncode(notificationData['schoolnotifications']));
  }

  static setEventsData(Map<String, dynamic> eventsData) async {
    return sp.setString('events', jsonEncode(eventsData['events']));
  }

  static setExamRoutineData(Map<String, dynamic> routineData) async {
    return sp.setString('ExamRoutine', jsonEncode(routineData));
  }

  static setSchoolDetails(Map<String, dynamic> schoolData) async {
    return sp.setString('SchoolData', jsonEncode(schoolData['events']));
  }

  static setDueDetails(Map<String, dynamic> duedata) async {
    return sp.setString('dueDetails', jsonEncode(duedata['due_details']));
  }

  static setLibraryDetails(Map<String, dynamic> duedata) async {
    return sp.setString('library', jsonEncode(duedata['library']));
  }

  static Map<String, dynamic> get studentProfileMap =>
      jsonDecode(sp.getString('profileData'));

  static List get notificationsMap => jsonDecode(sp.getString('notifications'));

  static List get eventsMap => jsonDecode(sp.getString('events'));

  static List get examRoutineMap => jsonDecode(sp.getString('ExamRoutine'));

  static Map<String, dynamic> get dueDetailsMap =>
      jsonDecode(sp.getString('dueDetails'));

  static List get libraryMap => jsonDecode(sp.getString('library'));
}
