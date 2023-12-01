import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/// Call local storage with [shared_preferences]
class SharedPref {
  /// read data with [key]
  Future read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String string = prefs.getString(key) ?? "";
    if (string != "") {
      return json.decode(string);
    } else {
      return null;
    }
  }

  /// save to storage with [key] and [value]
  Future save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  /// remove from storage with [key]
  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
