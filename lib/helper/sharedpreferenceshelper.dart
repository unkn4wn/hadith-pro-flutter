import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setString(String key, String value) async {
    return (await _prefs?.setString(key, value)) ?? false;
  }

  static String getString(String key, String defaultValue) {
    return _prefs?.getString(key) ?? defaultValue;
  }

  static Future<bool> setBool(String key, bool value) async {
    return (await _prefs?.setBool(key, value)) ?? false;
  }

  static bool getBool(String key, bool defaultValue) {
    return _prefs?.getBool(key) ?? defaultValue;
  }

  static Future<bool> setInt(String key, int value) async {
    return (await _prefs?.setInt(key, value)) ?? false;
  }

  static int getInt(String key, int defaultValue) {
    return _prefs?.getInt(key) ?? defaultValue;
  }

  static Future<bool> setDouble(String key, double value) async {
    return (await _prefs?.setDouble(key, value)) ?? false;
  }

  static double getDouble(String key, double defaultValue) {
    return _prefs?.getDouble(key) ?? defaultValue;
  }

  static Future<bool> remove(String key) async {
    return (await _prefs?.remove(key)) ?? false;
  }

  static Future<bool> clear() async {
    return (await _prefs?.clear()) ?? false;
  }

  static Future<void> setFirstStart() async {
    await setBool('isFirstStart', false);
  }

  static Future<void> resetSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
