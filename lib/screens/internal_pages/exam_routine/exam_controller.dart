import 'package:flutter/material.dart';
import 'package:schoolapp/screens/login/login_manager.dart';
import 'package:schoolapp/screens/profile/profile_manager.dart';
import 'package:schoolapp/services/shared_prefrernces/shared_pref.dart';

ExamManager examManager = ExamManager();

class ExamManager {
  Map<String, dynamic> _examRoutines;

  ValueNotifier<DataFetchState> get currentState {
    DataFetchState state;
    //if (LocalStorage.examRoutineMap!=null) {
    if (false) {
    } else
      state = DataFetchState.error;
    _notifier ??= ValueNotifier(state);
    return _notifier;
  }

  ValueNotifier<DataFetchState> _notifier;

  String _errorMessage;

  String get errorText => _errorMessage;

  ExamManager() {
    getExamRoutines();
  }

  getExamRoutines() async {
    UserAuthentication.postTo(
        url: UserAuthentication.getExamRoutine,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${LocalStorage.accessToken}'
        },
        onError: (errmsg) {
          _errorMessage = errmsg;
        },
        onSuccess: (decodedData) async {
          await LocalStorage.setExamRoutineData(decodedData);
          _examRoutines = decodedData['examlist'];
          _notifier?.value = DataFetchState.loaded;
        });
  }

  Widget mamage({
    Widget Function() loading,
    Widget Function(Map<String, dynamic>) loaded,
    Widget Function(String message) error,
  }) {
    return ValueListenableBuilder<DataFetchState>(
        valueListenable: currentState,
        builder: (_, DataFetchState state, child) {
          if (state == DataFetchState.loaded) {
            return loaded(_examRoutines);
          } else if (state == DataFetchState.error) return error(errorText);
          return CircularProgressIndicator();
        });
  }
}
