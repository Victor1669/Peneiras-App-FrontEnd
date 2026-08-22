import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> saveString(String key, String value) async {
    return await _prefs?.setString(key, value) ?? false;
  }

  static Future<bool> saveBool(String key, bool value) async {
    return await _prefs?.setBool(key, value) ?? false;
  }

  static Future<bool> saveInt(String key, int value) async {
    return await _prefs?.setInt(key, value) ?? false;
  }

  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  static bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  static int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  static Future<bool> remove(String key) async {
    return await _prefs?.remove(key) ?? false;
  }

  static bool hasKey(String key) {
    return _prefs?.containsKey(key) ?? false;
  }

  static Future<bool> clearAll() async {
    return await _prefs?.clear() ?? false;
  }
}
