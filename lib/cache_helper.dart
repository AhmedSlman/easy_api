import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _prefs;
  static const String _tokenKey = 'auth_token';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String? getToken() {
    return _prefs?.getString(_tokenKey);
  }

  static Future<bool> setToken(String token) async {
    return await _prefs?.setString(_tokenKey, token) ?? false;
  }

  static Future<bool> removeToken() async {
    return await _prefs?.remove(_tokenKey) ?? false;
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
