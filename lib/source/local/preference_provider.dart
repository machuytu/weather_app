import 'package:shared_preferences/shared_preferences.dart';

import 'preference_name.dart';

class PreferenceProvider {
  static SharedPreferences? _prefs;
  static final Map<String, dynamic> _memoryPrefs = <String, dynamic>{};

  static Future<SharedPreferences?> load() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs;
  }

  static Future setString(String key, String value) async {
    await load();
    await _prefs!.setString(key, value);
    _memoryPrefs[key] = value;
  }

  static Future setInt(String key, int value) async {
    await load();
    await _prefs!.setInt(key, value);
    _memoryPrefs[key] = value;
  }

  static Future setDouble(String key, double value) async {
    await load();
    await _prefs!.setDouble(key, value);
    _memoryPrefs[key] = value;
  }

  static Future setBool(String key, bool value) async {
    await load();
    await _prefs!.setBool(key, value);
    _memoryPrefs[key] = value;
  }

  static Future<String?> getString(String key) async {
    await load();
    String? val;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }

    val ??= _prefs?.getString(key);

    _memoryPrefs[key] = val;
    return val;
  }

  static Future<String?> getToken() async =>
      await getString(PreferenceNames.token);

  static Future removeAll() async {
    await load();
    await _prefs!.clear();
    _memoryPrefs.clear();
  }

  static Future remove(String key) async {
    await load();
    await _prefs!.remove(key);
  }
}
