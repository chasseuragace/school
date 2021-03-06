import 'package:flutter/material.dart';
import 'package:schoolapp/screens/login/login_manager.dart';
import 'package:schoolapp/screens/profile/profile_manager.dart';
import 'package:schoolapp/services/shared_prefrernces/shared_pref.dart';

EventsManager eventsManager = EventsManager();

class EventsManager {
  EventsManager() {
    _getEvents();
  }

  ValueNotifier<DataFetchState> get currentState {
    DataFetchState state;
    if (LocalStorage.eventsMap != null) {
      _events = EventsData();
      _events.events =
          LocalStorage.eventsMap.map((e) => Events.fromJson(e)).toList();
      state = DataFetchState.loaded;
    } else
      state = DataFetchState.error;
    _notifier ??= ValueNotifier(state);
    return _notifier;
  }

  EventsData _events;

  EventsData get eventsData => _events;

  ValueNotifier<DataFetchState> _notifier;

  String _errorMessage;

  String get errorText => _errorMessage;

  _getEvents() async {
    UserAuthentication.postTo(
        url: UserAuthentication.events,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${LocalStorage.accessToken}'
        },
        onError: (errmsg) {
          _errorMessage = errmsg;
        },
        onSuccess: (decodedData) async {
          await LocalStorage.setEventsData(decodedData);
          _events = EventsData.fromJson(decodedData);
          _notifier?.value = DataFetchState.loaded;
        });
  }

  Widget manage({
    Widget Function() loading,
    Widget Function(List<Events> events) loaded,
    Widget Function(String message) error,
  }) {
    return ValueListenableBuilder<DataFetchState>(
        valueListenable: currentState,
        builder: (_, DataFetchState state, child) {
          if (state == DataFetchState.loaded) {
            return loaded(eventsData.events);
          } else if (state == DataFetchState.error) return error(errorText);
          return loading();
        });
  }
}

class EventsData {
  int statusCode;
  bool error;
  List<Events> events;
  String message;

  EventsData({this.statusCode, this.error, this.events, this.message});

  EventsData.fromJson(Map<String, dynamic> json) {
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
  int enId;
  String notificationTitle;
  String notification;
  String notificationLink;
  String notificationImage;
  String eventDate;
  String createdAt;
  String updatedAt;

  Events(
      {this.enId,
      this.notificationTitle,
      this.notification,
      this.notificationLink,
      this.notificationImage,
      this.eventDate,
      this.createdAt,
      this.updatedAt});

  Events.fromJson(Map<String, dynamic> json) {
    enId = json['en_id'];
    notificationTitle = json['notification_title'];
    notification = json['notification'];
    notificationLink = json['notification_link'];
    notificationImage = json['notification_image'];
    eventDate = json['event_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en_id'] = this.enId;
    data['notification_title'] = this.notificationTitle;
    data['notification'] = this.notification;
    data['notification_link'] = this.notificationLink;
    data['notification_image'] = this.notificationImage;
    data['event_date'] = this.eventDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
