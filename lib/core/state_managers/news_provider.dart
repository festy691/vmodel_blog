import 'dart:convert';
import 'dart:developer';

import 'package:blog/core/data/session_manager.dart';
import 'package:blog/core/services/news_service.dart';
import 'package:blog/core/utils/app_flushbar.dart';
import 'package:blog/core/utils/constants.dart';
import 'package:blog/models/api_response.dart';
import 'package:blog/models/new_model.dart';
import 'package:flutter/material.dart';

class NewsProvider with ChangeNotifier {
  NewsService _newsService;
  NewsProvider(NewsService newsService) : _newsService = newsService;

  final _loadingKey = GlobalKey<State>();

  List<NewsModel> newsList = [];
  List<NewsModel> newsSearchList = [];
  List<NewsModel> newsBookmarkList = [];

  NewsModel? news;

  bool isLoadingSingleNews = false;
  bool isLoadingNews = false;
  bool isAddingNews = false;
  bool isUpdatingNews = false;

  void loadingNews (bool status){
    isLoadingNews = status;
    notifyListeners();
  }

  void loadingSingleNews (bool status){
    isLoadingSingleNews = status;
    notifyListeners();
  }

  void loadAddNews (bool status){
    isAddingNews = status;
    notifyListeners();
  }

  void loadUpdateNews (bool status){
    isUpdatingNews = status;
    notifyListeners();
  }

  setNewsList(List<NewsModel> allNewsList){
    newsList = allNewsList;
    onSearch("");
    notifyListeners();
  }

  setNews(NewsModel? newsModel){
    news = newsModel;
    notifyListeners();
  }

  addBookMark (NewsModel newsModel) async {
    var newsJson = newsModel.toBookmark();
    var _list = [];
    _list.add(newsJson);
    for(NewsModel n in newsBookmarkList){
      _list.add(n.toBookmark());
      if (n.id == newsModel.id) {
        AppFlushBar.showInfo(context: globalContext!, message: "Post already in bookmark");
        return;
      }
    }
    SessionManager.instance.bookmarks = _list;
    loadBookmarks();
    AppFlushBar.showSuccess(context: globalContext!, message: "Post added to bookmark");
  }

  removeBookMark (NewsModel newsModel) async {
    var _list = [];
    newsBookmarkList.removeWhere((b) => b.id == newsModel.id);
    for(NewsModel n in newsBookmarkList){
      _list.add(n.toBookmark());
    }
    SessionManager.instance.bookmarks = _list;
    loadBookmarks();
    AppFlushBar.showSuccess(context: globalContext!, message: "Post removed from bookmark");
  }

  loadBookmarks(){
    try{
      var list = SessionManager.instance.bookmarks;
      newsBookmarkList = [];
      for(var n in list){
        newsBookmarkList.add(NewsModel.fromJson(n));
      }
      notifyListeners();
    } catch (e){
      print(e);
    }
  }

  onSearch(String value){
    newsSearchList = newsList.reversed.where((element) => element.title.toString().toLowerCase().contains(value.toLowerCase()) ||
        element.subtitle.toString().toLowerCase().contains(value.toLowerCase())).toList();
    notifyListeners();
  }

  Future<APIResponse> getNews({
    required BuildContext context,
    required bool isLocal,
  }) async {
    try {
      await Future.delayed(const Duration(microseconds: 300));
      loadingNews(true);
      APIResponse result = await _newsService.getNews(isLocal: isLocal);

      if (result.status) {
        List<NewsModel> list = [];
        for (final data in result.data) {
          list.add(NewsModel.fromJson(data));
        }
        setNewsList(list);
      }
      loadingNews(false);
      return result;
    } catch (e, s) {
      loadingNews(false);
      return APIResponse(status: false, message: e.toString());
    }
  }

  Future<APIResponse> getSingleNews({
    required BuildContext context,
    required String id,
  }) async {
    try {
      await Future.delayed(const Duration(microseconds: 300));
      loadingSingleNews(true);
      APIResponse result = await _newsService.getSingleNews(id: id);

      if (result.status && result.data != null) {
        NewsModel n = NewsModel.fromJson(result.data);
        setNews(n);
      }
      loadingSingleNews(false);
      return result;
    } catch (e, s) {
      loadingSingleNews(false);
      return APIResponse(status: false, message: e.toString());
    }
  }

  Future<APIResponse> deleteNews({
    required BuildContext context,
    required String id,
  }) async {
    try {
      APIResponse result = await _newsService.deleteNews(id: id);

      if (result.status) {
        getNews(context: context, isLocal: false);
      }
      return result;
    } catch (e, s) {
      return APIResponse(status: false, message: e.toString());
    }
  }

  Future<APIResponse> addNews({
    required BuildContext context,
    required NewsModel newsModel,
  }) async {
    try {
      loadAddNews(true);
      APIResponse result = await _newsService.addNews(news: newsModel);

      if (result.status) {
        await getNews(context: context, isLocal: false);
      } else {
        AppFlushBar.showError(context: context, message: result.message);
      }

      loadAddNews(false);
      return result;
    } catch (e, s) {
      loadAddNews(false);
      AppFlushBar.showError(context: context, message: "Failed to add post");
      return APIResponse(status: false, message: e.toString());
    }
  }

  Future<APIResponse> updateNews({
    required BuildContext context,
    required NewsModel newsModel,
    required String id,
  }) async {
    try {
      loadUpdateNews(true);
      APIResponse result = await _newsService.updateNews(news: newsModel, id: id);

      if (result.status) {
        await getNews(context: context, isLocal: false);
      } else {
        AppFlushBar.showError(context: context, message: result.message);
      }

      loadUpdateNews(false);
      return result;
    } catch (e, s) {
      loadUpdateNews(false);
      print(e);
      AppFlushBar.showError(context: context, message: "Failed to update post");
      return APIResponse(status: false, message: e.toString());
    }
  }

}