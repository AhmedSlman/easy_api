import 'package:shared_preferences/shared_preferences.dart';

/// A utility class for managing cached data using SharedPreferences.
/// 
/// This class provides methods for storing and retrieving various types of data
/// in the device's local storage.
class CacheHelper {
  static SharedPreferences? _prefs;

  /// Initializes the SharedPreferences instance.
  /// 
  /// This method should be called before using any other methods in this class.
  /// 
  /// Returns a Future that completes when the initialization is done.
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Stores a string value in the cache.
  /// 
  /// [key] is the key to store the value under.
  /// [value] is the string value to store.
  /// 
  /// Returns true if the value was successfully stored, false otherwise.
  static Future<bool> setString(String key, String value) async {
    return await _prefs?.setString(key, value) ?? false;
  }

  /// Retrieves a string value from the cache.
  /// 
  /// [key] is the key to retrieve the value for.
  /// 
  /// Returns the stored string value, or null if no value was found.
  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  /// Stores a boolean value in the cache.
  /// 
  /// [key] is the key to store the value under.
  /// [value] is the boolean value to store.
  /// 
  /// Returns true if the value was successfully stored, false otherwise.
  static Future<bool> setBool(String key, bool value) async {
    return await _prefs?.setBool(key, value) ?? false;
  }

  /// Retrieves a boolean value from the cache.
  /// 
  /// [key] is the key to retrieve the value for.
  /// 
  /// Returns the stored boolean value, or null if no value was found.
  static bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  /// Stores an integer value in the cache.
  /// 
  /// [key] is the key to store the value under.
  /// [value] is the integer value to store.
  /// 
  /// Returns true if the value was successfully stored, false otherwise.
  static Future<bool> setInt(String key, int value) async {
    return await _prefs?.setInt(key, value) ?? false;
  }

  /// Retrieves an integer value from the cache.
  /// 
  /// [key] is the key to retrieve the value for.
  /// 
  /// Returns the stored integer value, or null if no value was found.
  static int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  /// Stores a double value in the cache.
  /// 
  /// [key] is the key to store the value under.
  /// [value] is the double value to store.
  /// 
  /// Returns true if the value was successfully stored, false otherwise.
  static Future<bool> setDouble(String key, double value) async {
    return await _prefs?.setDouble(key, value) ?? false;
  }

  /// Retrieves a double value from the cache.
  /// 
  /// [key] is the key to retrieve the value for.
  /// 
  /// Returns the stored double value, or null if no value was found.
  static double? getDouble(String key) {
    return _prefs?.getDouble(key);
  }

  /// Stores a list of strings in the cache.
  /// 
  /// [key] is the key to store the value under.
  /// [value] is the list of strings to store.
  /// 
  /// Returns true if the value was successfully stored, false otherwise.
  static Future<bool> setStringList(String key, List<String> value) async {
    return await _prefs?.setStringList(key, value) ?? false;
  }

  /// Retrieves a list of strings from the cache.
  /// 
  /// [key] is the key to retrieve the value for.
  /// 
  /// Returns the stored list of strings, or null if no value was found.
  static List<String>? getStringList(String key) {
    return _prefs?.getStringList(key);
  }

  /// Removes a value from the cache.
  /// 
  /// [key] is the key of the value to remove.
  /// 
  /// Returns true if the value was successfully removed, false otherwise.
  static Future<bool> remove(String key) async {
    return await _prefs?.remove(key) ?? false;
  }

  /// Clears all values from the cache.
  /// 
  /// Returns true if all values were successfully cleared, false otherwise.
  static Future<bool> clear() async {
    return await _prefs?.clear() ?? false;
  }

  /// Stores the authentication token in the cache.
  /// 
  /// [token] is the token to store.
  /// 
  /// Returns true if the token was successfully stored, false otherwise.
  static Future<bool> setToken(String token) async {
    return await setString('token', token);
  }

  /// Retrieves the authentication token from the cache.
  /// 
  /// Returns the stored token, or null if no token was found.
  static String? getToken() {
    return getString('token');
  }

  /// Removes the authentication token from the cache.
  /// 
  /// Returns true if the token was successfully removed, false otherwise.
  static Future<bool> removeToken() async {
    return await remove('token');
  }

  static dynamic getData({required String key}) {
    return _prefs?.get(key);
  }

  static Future<bool> setData({required String key, required dynamic value}) async {
    if (value is String) return await _prefs?.setString(key, value) ?? false;
    if (value is bool) return await _prefs?.setBool(key, value) ?? false;
    if (value is int) return await _prefs?.setInt(key, value) ?? false;
    return await _prefs?.setDouble(key, value) ?? false;
  }
} 