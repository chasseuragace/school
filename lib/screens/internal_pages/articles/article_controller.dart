import 'package:flutter/material.dart';
import 'package:schoolapp/screens/login/login_manager.dart';
import 'package:schoolapp/screens/profile/profile_manager.dart';
import 'package:schoolapp/services/shared_prefrernces/shared_pref.dart';

ArticleManager articleManager = ArticleManager();

class ArticleManager {
  ValueNotifier<DataFetchState> get currentState {
    DataFetchState state;
    //if (LocalStorage.examRoutineMap!=null) {
    if (false) {
      _articles = ArticlesData();
      // var json =LocalStorage.schoolDetailsMap;

      state = DataFetchState.loaded;
    } else
      state = DataFetchState.error;
    _notifier ??= ValueNotifier(state);
    return _notifier;
  }

  ArticlesData _articles;

  ArticlesData get details => _articles;

  ValueNotifier<DataFetchState> _notifier;

  String _errorMessage;

  String get errorText => _errorMessage;

  ArticleManager() {
    getArticles();
  }

  getArticles() async {
    UserAuthentication.postTo(
        url: UserAuthentication.getArticles,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${LocalStorage.accessToken}'
        },
        onError: (errmsg) {
          _errorMessage = errmsg;
        },
        onSuccess: (decodedData) async {
          await LocalStorage.setSchoolDetails(decodedData);
          _articles = ArticlesData.fromJson(decodedData);
          _notifier?.value = DataFetchState.loaded;
        });
  }

  Widget mamage({
    Widget Function() loading,
    Widget Function(List<Articles>) loaded,
    Widget Function(String message) error,
  }) {
    return ValueListenableBuilder<DataFetchState>(
        valueListenable: currentState,
        builder: (_, DataFetchState state, child) {
          if (state == DataFetchState.loaded) {
            return loaded(_articles.articles);
          } else if (state == DataFetchState.error) return error(errorText);
          return CircularProgressIndicator();
        });
  }
}

class ArticlesData {
  int statusCode;
  bool error;
  List<Articles> articles;
  String message;

  ArticlesData({this.statusCode, this.error, this.articles, this.message});

  ArticlesData.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    error = json['error'];
    if (json['articles'] != null) {
      articles = new List<Articles>();
      json['articles'].forEach((v) {
        articles.add(new Articles.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['error'] = this.error;
    if (this.articles != null) {
      data['articles'] = this.articles.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Articles {
  int arId;
  String articleTitle;
  String article;
  String articleImage;
  String articleBy;
  String createdAt;
  String updatedAt;

  Articles(
      {this.arId,
      this.articleTitle,
      this.article,
      this.articleImage,
      this.articleBy,
      this.createdAt,
      this.updatedAt});

  Articles.fromJson(Map<String, dynamic> json) {
    arId = json['ar_id'];
    articleTitle = json['article_title'];
    article = json['article'];
    articleImage = json['article_image'];
    articleBy = json['article_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ar_id'] = this.arId;
    data['article_title'] = this.articleTitle;
    data['article'] = this.article;
    data['article_image'] = this.articleImage;
    data['article_by'] = this.articleBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
