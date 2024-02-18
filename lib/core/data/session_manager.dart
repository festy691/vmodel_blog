import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

/// A class for managing sessions, handles saving and retrieving of data
class SessionManager {
  SessionManager._internal();

  SharedPreferences? sharedPreferences;

  static SessionManager _instance = SessionManager._internal();

  factory SessionManager() => _instance;

  static SessionManager get instance => _instance;

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static const String KEY_AUTH_TOKEN = 'authToken';
  static const String KEY_APP_SESSION = 'app-session';
  static const String KEY_APP_BOOKMARK = 'app-bookmark';

  String get authToken =>  (sharedPreferences!.getString(KEY_AUTH_TOKEN) ?? '');
  set authToken(String authToken) => sharedPreferences!.setString(KEY_AUTH_TOKEN, authToken);

  List<dynamic> get bookmarks => json.decode(sharedPreferences!.getString(KEY_APP_BOOKMARK) ?? '[]');
  set bookmarks(List<dynamic> map) => sharedPreferences!.setString(KEY_APP_BOOKMARK, json.encode(map));

  save(String key, String value) async {
    try{
      await sharedPreferences!.setString(key, value);
    }catch(e){log(e.toString());}
  }

  delete(String key) async => await sharedPreferences!.remove(key);

  get(String key) async => sharedPreferences!.getString(key);

}
