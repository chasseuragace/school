import 'package:flutter/material.dart';
import 'package:schoolapp/screens/login/login_manager.dart';
import 'package:schoolapp/screens/profile/profile_manager.dart';
import 'package:schoolapp/services/shared_prefrernces/shared_pref.dart';

SchoolManager schoolManager = SchoolManager();

class SchoolManager {
  ValueNotifier<DataFetchState> get currentState {
    DataFetchState state;
    //if (LocalStorage.examRoutineMap!=null) {
    if (false) {
      _schoolDetails = SchoolDetailsData();
      // var json =LocalStorage.schoolDetailsMap;

      state = DataFetchState.loaded;
    } else
      state = DataFetchState.error;
    _notifier ??= ValueNotifier(state);
    return _notifier;
  }

  SchoolDetailsData _schoolDetails;

  SchoolDetailsData get details => _schoolDetails;

  ValueNotifier<DataFetchState> _notifier;

  String _errorMessage;

  String get errorText => _errorMessage;

  SchoolManager() {
    getSchoolDetails();
  }

  getSchoolDetails() async {
    UserAuthentication.postTo(
        url: UserAuthentication.getSchoolDetails,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${LocalStorage.accessToken}'
        },
        onError: (errmsg) {
          _errorMessage = errmsg;
        },
        onSuccess: (decodedData) async {
          await LocalStorage.setSchoolDetails(decodedData);
          _schoolDetails = SchoolDetailsData.fromJson(decodedData);
          _notifier?.value = DataFetchState.loaded;
        });
  }

  Widget mamage({
    Widget Function() loading,
    Widget Function(Events) loaded,
    Widget Function(String message) error,
  }) {
    return ValueListenableBuilder<DataFetchState>(
        valueListenable: currentState,
        builder: (_, DataFetchState state, child) {
          if (state == DataFetchState.loaded) {
            return loaded(_schoolDetails.events.first);
          } else if (state == DataFetchState.error) return error(errorText);
          return CircularProgressIndicator();
        });
  }
}

class SchoolDetailsData {
  int statusCode;
  bool error;
  List<Events> events;
  String message;

  SchoolDetailsData({this.statusCode, this.error, this.events, this.message});

  SchoolDetailsData.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    error = json['error'];
    if (json['events'] != null) {
      events = new List<Events>();
      json['events'].forEach((v) {
        events.add(new Events.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['error'] = this.error;
    if (this.events != null) {
      data['events'] = this.events.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Events {
  int sId;
  String schoolName;
  String address;
  String phoneNumber;
  String email;
  String estdDate;
  String website;
  String description;
  String createdAt;
  String updatedAt;

  Events(
      {this.sId,
      this.schoolName,
      this.address,
      this.phoneNumber,
      this.email,
      this.estdDate,
      this.website,
      this.description,
      this.createdAt,
      this.updatedAt});

  Events.fromJson(Map<String, dynamic> json) {
    sId = json['s_id'];
    schoolName = json['school_name'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    estdDate = json['estd_date'];
    website = json['website'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s_id'] = this.sId;
    data['school_name'] = this.schoolName;
    data['address'] = this.address;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['estd_date'] = this.estdDate;
    data['website'] = this.website;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
