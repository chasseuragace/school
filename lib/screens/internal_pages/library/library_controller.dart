import 'package:flutter/material.dart';
import 'package:schoolapp/screens/login/login_manager.dart';
import 'package:schoolapp/screens/profile/profile_manager.dart';
import 'package:schoolapp/services/shared_prefrernces/shared_pref.dart';

LibraryManager libraryManager = LibraryManager();

class LibraryManager {
  LibraryManager() {
    _getLibrary();
  }

  ValueNotifier<DataFetchState> get currentState {
    DataFetchState state;
    //if (LocalStorage.libraryMap!=null) {
    if (false) {
      _books = LibraryDetails();
      _books.library =
          LocalStorage.libraryMap.map((e) => Library.fromJson(e)).toList();

      state = DataFetchState.loaded;
    } else
      state = DataFetchState.error;
    _notifier ??= ValueNotifier(state);
    return _notifier;
  }

  LibraryDetails _books;

  LibraryDetails get books => _books;

  ValueNotifier<DataFetchState> _notifier;

  String _errorMessage;

  _getLibrary() async {
    UserAuthentication.postTo(
        url: UserAuthentication.getLibrary,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${LocalStorage.accessToken}'
        },
        onError: (errmsg) {
          _errorMessage = errmsg;
        },
        onSuccess: (decodedData) async {
          await LocalStorage.setLibraryDetails(decodedData);
          _books = LibraryDetails.fromJson(decodedData);
          _notifier?.value = DataFetchState.loaded;
        });
  }

  Widget mamage({
    Widget Function() loading,
    Widget Function(List<Library> books) loaded,
    Widget Function(String message) error,
  }) {
    return ValueListenableBuilder<DataFetchState>(
        valueListenable: currentState,
        builder: (_, DataFetchState state, child) {
          if (state == DataFetchState.loaded) {
            return loaded(books.library);
          } else if (state == DataFetchState.error) return error(_errorMessage);
          return CircularProgressIndicator();
        });
  }
}

class LibraryDetails {
  int statusCode;
  bool error;
  List<Library> library;
  String message;

  LibraryDetails({this.statusCode, this.error, this.library, this.message});

  LibraryDetails.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    error = json['error'];
    if (json['library'] != null) {
      library = new List<Library>();
      json['library'].forEach((v) {
        library.add(new Library.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['error'] = this.error;
    if (this.library != null) {
      data['library'] = this.library.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Library {
  int liId;
  String bookName;
  String studentName;
  int studentId;
  String bookId;
  String dateOfBorrow;
  String submissionDate;
  int borrowStatus;
  String createdAt;
  String updatedAt;

  Library(
      {this.liId,
      this.bookName,
      this.studentName,
      this.studentId,
      this.bookId,
      this.dateOfBorrow,
      this.submissionDate,
      this.borrowStatus,
      this.createdAt,
      this.updatedAt});

  Library.fromJson(Map<String, dynamic> json) {
    liId = json['li_id'];
    bookName = json['book_name'];
    studentName = json['student_name'];
    studentId = json['student_id'];
    bookId = json['book_id'];
    dateOfBorrow = json['date_of_borrow'];
    submissionDate = json['submission_date'];
    borrowStatus = json['borrow_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['li_id'] = this.liId;
    data['book_name'] = this.bookName;
    data['student_name'] = this.studentName;
    data['student_id'] = this.studentId;
    data['book_id'] = this.bookId;
    data['date_of_borrow'] = this.dateOfBorrow;
    data['submission_date'] = this.submissionDate;
    data['borrow_status'] = this.borrowStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
