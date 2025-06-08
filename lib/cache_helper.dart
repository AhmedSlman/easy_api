import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static dynamic getData({required String key}) {
    return _prefs?.get(key);
  }

  static Future<bool> setData(
      {required String key, required dynamic value}) async {
    if (value is String) return await _prefs?.setString(key, value) ?? false;
    if (value is bool) return await _prefs?.setBool(key, value) ?? false;
    if (value is int) return await _prefs?.setInt(key, value) ?? false;
    return await _prefs?.setDouble(key, value) ?? false;
  }
}
