// import 'dart:html';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {
  Future read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String string = prefs.getString(key) ?? "";
    if (string != "") {
      return json.decode(string);
    } else {
      return null;
    }
  }

  Future save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  setListData(String key, List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, value);
  }

  setcheckDownloadMusic(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  Future<bool> checkDownload(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) as bool;
  }

  Future<List<String>> getListData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) as List<String>;
  }
}
