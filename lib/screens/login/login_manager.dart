import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:schoolapp/services/shared_prefrernces/shared_pref.dart';

enum LoginStates { loggedIn, loggedOut, loading, error }

class LoginManger {
  ValueNotifier<LoginStates> _notifier;
  String _errorMessage;

  String get errorText => _errorMessage;

  ValueNotifier<LoginStates> get currentState {
    LoginStates state;
    if (LocalStorage.isLoggedIn)
      state = LoginStates.loggedIn;
    else
      state = LoginStates.loggedOut;
    _notifier ??= ValueNotifier(state);
    return _notifier;
  }

  login({String username, String password}) async {
    _notifier.value = LoginStates.loading;
    UserAuthentication.postTo(
        url: UserAuthentication.loginUrl,
        headers: {'Accept': 'application/json'},
        fields: {
          'email': 'sewasadan9999@gmail.com',
          'password': 'dbnaxakaa',
          'position': 'parent', // parent teacher principal admin
          'grant_type': 'password',
          'client_id': '9',
          'client_secret': '70xNPKMfSrgHH40bUmaFK3ruPYtsYToavc9kuQRU'
        },
        onError: (errmsg) {
          _errorMessage = errmsg;
          _notifier.value = LoginStates.error;
          Future.delayed(Duration(seconds: 2), () {
            _notifier.value = LoginStates.loggedOut;
          });
        },
        onSuccess: (data) {
          LocalStorage.setLogin();
          _notifier.value = LoginStates.loggedIn;
          _saveKey(data['data']['access_token']);
        });
  }

  logout(Function() onError) async {
    var result;

    await Future.delayed(Duration(seconds: 3), () {
      //todo hit logout ko api
      result = true;
    });
    if (result == null || result is String) {
      //todo error huda error dekhaune
      onError();
    } else {
      LocalStorage.setLogin(setLoginTo: false);
      //todo clear app data

      _notifier.value = LoginStates.loggedOut;
    }
  }

  void _saveKey(accessToken) {
    LocalStorage.setAccessToken(accessToken);
  }
}

class UserAuthentication {
  static String getProfile =
      "https://www.initialstechnology.com/schoolapp/public/api/profile";
  static String loginUrl =
      "https://www.initialstechnology.com/schoolapp/public/api/login";
  static String notifications =
      "https://www.initialstechnology.com/schoolapp/public/api/get-all-notification";
  static String events =
      "https://www.initialstechnology.com/schoolapp/public/api/events";
  static String getExamRoutine =
      "https://www.initialstechnology.com/schoolapp/public/api/examroutine";
  static String getSchoolDetails =
      "https://www.initialstechnology.com/schoolapp/public/api/schooldetails";
  static String getArticles =
      "https://www.initialstechnology.com/schoolapp/public/api/articles";
  static String getClassRoutine =
      "https://www.initialstechnology.com/schoolapp/public/api/classroutine";
  static String getDueDetails =
      "https://www.initialstechnology.com/schoolapp/public/api/get-due-details";
  static String getLibrary =
      "https://www.initialstechnology.com/schoolapp/public/api/library";
  static String submitFeedBack =
      "https://www.initialstechnology.com/schoolapp/public/api/submit-suggestion";

  static Future postTo(
      {String url,
      Map<String, String> fields,
      Map<String, String> headers,
      onSuccess(dynamic data),
      onError(String errorMsg)}) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.fields.addAll(fields ?? {});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        //response was successful
        var data = jsonDecode(await response.stream.bytesToString());
        //response doenst have error
        if (data['error'] == true)
          onError(data['message']);
        //login position is parent
        else
          onSuccess(data);
        //post request data
        print("---------------post request data------------------");
        print(data);
      } else {
        print("---------------post request failure------------------");
        print(response.reasonPhrase);
        onError('Server replied with a ${response.reasonPhrase}Error');
      }
    } on Exception catch (e) {
      if (e is SocketException)
        onError('Limited connectivity! Is your internet connection working?');
      else
        onError('${e.runtimeType}: Poor Johny drove too deep into the forest!');
    }
  }
}
