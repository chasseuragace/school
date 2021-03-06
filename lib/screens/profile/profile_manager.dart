import 'package:flutter/material.dart';
import 'package:schoolapp/screens/login/login_manager.dart';
import 'package:schoolapp/services/shared_prefrernces/shared_pref.dart';

enum DataFetchState { idle, loading, loaded, error }

ProfileManager profileManager = ProfileManager();

class ProfileManager {
  ProfileManager() {
    _getStudentProfile();
  }

  ValueNotifier<DataFetchState> get currentState {
    DataFetchState state;
    if (LocalStorage.studentProfileMap != null) {
      _profile = ProfileData();
      _profile.profile = Profile.fromJson(LocalStorage.studentProfileMap);
      state = DataFetchState.loaded;
    } else
      state = DataFetchState.error;
    _notifier ??= ValueNotifier(state);
    return _notifier;
  }

  ProfileData _profile;

  ProfileData get profile => _profile;

  ValueNotifier<DataFetchState> _notifier;

  String _errorMessage;

  String get errorText => _errorMessage;

  _getStudentProfile() async {
    UserAuthentication.postTo(
        url: UserAuthentication.getProfile,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${LocalStorage.accessToken}'
        },
        onError: (errmsg) {
          _errorMessage = errmsg;
        },
        onSuccess: (decodedData) async {
          await LocalStorage.setProfileData(decodedData);
          _profile = ProfileData.fromJson(decodedData);
          _notifier?.value = DataFetchState.loaded;
        });
  }

  Widget mamage({
    Widget Function() loading,
    Widget Function(Profile profile) loaded,
    Widget Function(String message) error,
  }) {
    return ValueListenableBuilder<DataFetchState>(
        valueListenable: currentState,
        builder: (_, DataFetchState state, child) {
          if (state == DataFetchState.loaded) {
            return loaded(profile.profile);
          } else if (state == DataFetchState.error) return error(errorText);
          return CircularProgressIndicator();
        });
  }
}

class ProfileData {
  int statusCode;
  bool error;
  Profile profile;
  String message;

  ProfileData({this.statusCode, this.error, this.profile, this.message});

  ProfileData.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    error = json['error'];
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['error'] = this.error;
    if (this.profile != null) {
      data['profile'] = this.profile.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Profile {
  int stId;
  String studentName;
  String studentPhoto;
  int classId;
  String fatherName;
  String motherName;
  String localGuardian;
  String bloodGroup;
  String currentAddress;
  String dob;
  String createdAt;
  String updatedAt;
  String className;

  Profile(
      {this.stId,
      this.studentName,
      this.studentPhoto,
      this.classId,
      this.fatherName,
      this.motherName,
      this.localGuardian,
      this.bloodGroup,
      this.currentAddress,
      this.dob,
      this.createdAt,
      this.updatedAt,
      this.className});

  Profile.fromJson(Map<String, dynamic> json) {
    stId = json['st_id'];
    studentName = json['student_name'];
    studentPhoto = json['student_photo'];
    classId = json['class_id'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    localGuardian = json['local_guardian'];
    bloodGroup = json['blood_group'];
    currentAddress = json['current_address'];
    dob = json['dob'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    className = json['class_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['st_id'] = this.stId;
    data['student_name'] = this.studentName;
    data['student_photo'] = this.studentPhoto;
    data['class_id'] = this.classId;
    data['father_name'] = this.fatherName;
    data['mother_name'] = this.motherName;
    data['local_guardian'] = this.localGuardian;
    data['blood_group'] = this.bloodGroup;
    data['current_address'] = this.currentAddress;
    data['dob'] = this.dob;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['class_name'] = this.className;
    return data;
  }
}
