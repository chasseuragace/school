import 'package:flutter/material.dart';
import 'package:schoolapp/screens/login/login_manager.dart';
import 'package:schoolapp/screens/profile/profile_manager.dart';
import 'package:schoolapp/services/shared_prefrernces/shared_pref.dart';

NotificationManager notificationManager = NotificationManager();

class NotificationManager {
  NotificationManager() {
    _getNotifications();
  }

  ValueNotifier<DataFetchState> get currentState {
    print('${LocalStorage.notificationsMap}');
    DataFetchState state;
    if (LocalStorage.notificationsMap != null) {
      _notifications = NotificationsData();
      _notifications.schoolnotifications = LocalStorage.notificationsMap
          .map((e) => Schoolnotifications.fromJson(e))
          .toList();
      state = DataFetchState.loaded;
    } else
      state = DataFetchState.error;
    _notifier ??= ValueNotifier(state);
    return _notifier;
  }

  NotificationsData _notifications;

  NotificationsData get notificataions => _notifications;

  ValueNotifier<DataFetchState> _notifier;

  String _errorMessage;

  String get errorText => _errorMessage;

  _getNotifications() async {
    UserAuthentication.postTo(
        url: UserAuthentication.notifications,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${LocalStorage.accessToken}'
        },
        onError: (errmsg) {
          _errorMessage = errmsg;
        },
        onSuccess: (decodedData) async {
          await LocalStorage.setNotificationsData(decodedData);
          _notifications = NotificationsData.fromJson(decodedData);
          _notifier?.value = DataFetchState.loaded;
        });
  }

  Widget manage({
    Widget Function() loading,
    Widget Function(List<Schoolnotifications> notifications) loaded,
    Widget Function(String message) error,
  }) {
    return ValueListenableBuilder<DataFetchState>(
        valueListenable: currentState,
        builder: (_, DataFetchState state, child) {
          if (state == DataFetchState.loaded) {
            return loaded(notificataions.schoolnotifications);
          } else if (state == DataFetchState.error) return error(errorText);
          return loading();
        });
  }
}

class NotificationsData {
  int statusCode;
  bool error;
  List<Schoolnotifications> schoolnotifications;
  String message;

  NotificationsData(
      {this.statusCode, this.error, this.schoolnotifications, this.message});

  NotificationsData.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    error = json['error'];
    if (json['schoolnotifications'] != null) {
      schoolnotifications = <Schoolnotifications>[];
      json['schoolnotifications'].forEach((v) {
        schoolnotifications.add(new Schoolnotifications.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['error'] = this.error;
    if (this.schoolnotifications != null) {
      data['schoolnotifications'] =
          this.schoolnotifications.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Schoolnotifications {
  int nId;
  String notification;
  Null notificationLink;
  Null notificationImage;
  String createdAt;
  String updatedAt;
  String notificationTitle;

  Schoolnotifications(
      {this.nId,
      this.notification,
      this.notificationLink,
      this.notificationImage,
      this.createdAt,
      this.updatedAt,
      this.notificationTitle});

  Schoolnotifications.fromJson(Map<String, dynamic> json) {
    nId = json['n_id'];
    notification = json['notification'];
    notificationLink = json['notification_link'];
    notificationImage = json['notification_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    notificationTitle = json['notification_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['n_id'] = this.nId;
    data['notification'] = this.notification;
    data['notification_link'] = this.notificationLink;
    data['notification_image'] = this.notificationImage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['notification_title'] = this.notificationTitle;
    return data;
  }
}
