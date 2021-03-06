import 'package:flutter/material.dart';
import 'package:schoolapp/screens/login/login_manager.dart';
import 'package:schoolapp/screens/profile/profile_manager.dart';
import 'package:schoolapp/services/shared_prefrernces/shared_pref.dart';

ClassRoutineManager routineManager = ClassRoutineManager();

class ClassRoutineManager {
  ValueNotifier<DataFetchState> get currentState {
    DataFetchState state;
    //if (LocalStorage.examRoutineMap!=null) {
    if (false) {
      //_schoolDetails =SchoolDetailsData();
      // var json =LocalStorage.schoolDetailsMap;

      state = DataFetchState.loaded;
    } else
      state = DataFetchState.error;
    _notifier ??= ValueNotifier(state);
    return _notifier;
  }

  ClassRoutineData _routineDetails;

  ClassRoutineData get details => _routineDetails;

  ValueNotifier<DataFetchState> _notifier;

  String _errorMessage;

  String get errorText => _errorMessage;

  ClassRoutineManager() {
    getSchoolDetails();
  }

  getSchoolDetails() async {
    UserAuthentication.postTo(
        url: UserAuthentication.getClassRoutine,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${LocalStorage.accessToken}'
        },
        onError: (errmsg) {
          _errorMessage = errmsg;
        },
        onSuccess: (decodedData) async {
          //  await LocalStorage.setSchoolDetails(decodedData);
          _routineDetails = ClassRoutineData.fromJson(decodedData);
          _notifier?.value = DataFetchState.loaded;
        });
  }

  Widget mamage({
    Widget Function() loading,
    Widget Function(Routine) loaded,
    Widget Function(String message) error,
  }) {
    return ValueListenableBuilder<DataFetchState>(
        valueListenable: currentState,
        builder: (_, DataFetchState state, child) {
          if (state == DataFetchState.loaded) {
            return loaded(_routineDetails.routine);
          } else if (state == DataFetchState.error) return error(errorText);
          return CircularProgressIndicator();
        });
  }
}

class ClassRoutineData {
  int statusCode;
  bool error;
  Routine routine;
  String message;

  ClassRoutineData({this.statusCode, this.error, this.routine, this.message});

  ClassRoutineData.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    error = json['error'];
    routine =
        json['routine'] != null ? new Routine.fromJson(json['routine']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['error'] = this.error;
    if (this.routine != null) {
      data['routine'] = this.routine.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Routine {
  List<Day> sunday;
  List<Day> monday;
  List<Day> tuesday;
  List<Day> wednesday;
  List<Day> thursday;
  List<Day> friday;
  List<Day> saturday;

  Routine(
      {this.sunday,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday});

  Routine.fromJson(Map<String, dynamic> json) {
    if (json['Sunday'] != null) {
      sunday = <Day>[];
      json['Sunday'].forEach((v) {
        sunday.add(new Day.fromJson(v));
      });
    }
    if (json['Monday'] != null) {
      monday = <Day>[];
      json['Monday'].forEach((v) {
        monday.add(new Day.fromJson(v));
      });
    }
    if (json['Tuesday'] != null) {
      tuesday = <Day>[];
      json['Tuesday'].forEach((v) {
        tuesday.add(new Day.fromJson(v));
      });
    }
    if (json['Wednesday'] != null) {
      wednesday = <Day>[];
      json['Wednesday'].forEach((v) {
        wednesday.add(new Day.fromJson(v));
      });
    }
    if (json['Thursday'] != null) {
      thursday = <Day>[];
      json['Thursday'].forEach((v) {
        thursday.add(new Day.fromJson(v));
      });
    }
    if (json['Friday'] != null) {
      friday = <Day>[];
      json['Friday'].forEach((v) {
        friday.add(new Day.fromJson(v));
      });
    }
    if (json['Saturday'] != null) {
      saturday = <Day>[];
      json['Saturday'].forEach((v) {
        saturday.add(new Day.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sunday != null) {
      data['Sunday'] = this.sunday.map((v) => v.toJson()).toList();
    }
    if (this.monday != null) {
      data['Monday'] = this.monday.map((v) => v.toJson()).toList();
    }
    if (this.tuesday != null) {
      data['Tuesday'] = this.tuesday.map((v) => v.toJson()).toList();
    }
    if (this.wednesday != null) {
      data['Wednesday'] = this.wednesday.map((v) => v.toJson()).toList();
    }
    if (this.thursday != null) {
      data['Thursday'] = this.thursday.map((v) => v.toJson()).toList();
    }
    if (this.friday != null) {
      data['Friday'] = this.friday.map((v) => v.toJson()).toList();
    }
    if (this.saturday != null) {
      data['Saturday'] = this.saturday.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Day {
  String teacherName;
  String startTime;
  String endTime;
  String subjectName;
  String dayName;

  Day(
      {this.teacherName,
      this.startTime,
      this.endTime,
      this.subjectName,
      this.dayName});

  Day.fromJson(Map<String, dynamic> json) {
    teacherName = json['teacher_name'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    subjectName = json['subject_name'];
    dayName = json['day_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['teacher_name'] = this.teacherName;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['subject_name'] = this.subjectName;
    data['day_name'] = this.dayName;
    return data;
  }
}
