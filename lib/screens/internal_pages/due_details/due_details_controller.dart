import 'package:flutter/material.dart';
import 'package:schoolapp/screens/login/login_manager.dart';
import 'package:schoolapp/screens/profile/profile_manager.dart';
import 'package:schoolapp/services/shared_prefrernces/shared_pref.dart';

DueDetailsManager dueDetailsManager = DueDetailsManager();

class DueDetailsManager {
  DueDetailsManager() {
    _getStudentDue();
  }

  ValueNotifier<DataFetchState> get currentState {
    DataFetchState state;
    if (LocalStorage.dueDetailsMap != null) {
      _due = Due();
      _due.dueDetails = DueDetails.fromJson(LocalStorage.dueDetailsMap);
      state = DataFetchState.loaded;
    } else
      state = DataFetchState.error;
    _notifier ??= ValueNotifier(state);
    return _notifier;
  }

  Due _due;

  Due get due => _due;

  ValueNotifier<DataFetchState> _notifier;

  String _errorMessage;

  _getStudentDue() async {
    UserAuthentication.postTo(
        url: UserAuthentication.getDueDetails,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${LocalStorage.accessToken}'
        },
        onError: (errmsg) {
          _errorMessage = errmsg;
        },
        onSuccess: (decodedData) async {
          await LocalStorage.setDueDetails(decodedData);
          _due = Due.fromJson(decodedData);
          _notifier?.value = DataFetchState.loaded;
        });
  }

  Widget mamage({
    Widget Function() loading,
    Widget Function(DueDetails profile) loaded,
    Widget Function(String message) error,
  }) {
    return ValueListenableBuilder<DataFetchState>(
        valueListenable: currentState,
        builder: (_, DataFetchState state, child) {
          if (state == DataFetchState.loaded) {
            return loaded(due.dueDetails);
          } else if (state == DataFetchState.error) return error(_errorMessage);
          return CircularProgressIndicator();
        });
  }
}

class Due {
  int statusCode;
  bool error;
  DueDetails dueDetails;
  String message;

  Due({this.statusCode, this.error, this.dueDetails, this.message});

  Due.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    error = json['error'];
    dueDetails = json['due_details'] != null
        ? new DueDetails.fromJson(json['due_details'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['error'] = this.error;
    if (this.dueDetails != null) {
      data['due_details'] = this.dueDetails.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class DueDetails {
  int dueId;
  int stId;
  int totalDue;
  int previousDue;
  String deadline;
  String createdAt;
  String updatedAt;

  DueDetails(
      {this.dueId,
      this.stId,
      this.totalDue,
      this.previousDue,
      this.deadline,
      this.createdAt,
      this.updatedAt});

  DueDetails.fromJson(Map<String, dynamic> json) {
    dueId = json['due_id'];
    stId = json['st_id'];
    totalDue = json['total_due'];
    previousDue = json['previous_due'];
    deadline = json['deadline'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['due_id'] = this.dueId;
    data['st_id'] = this.stId;
    data['total_due'] = this.totalDue;
    data['previous_due'] = this.previousDue;
    data['deadline'] = this.deadline;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
