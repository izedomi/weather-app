import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static storeStringItem(String key, String value) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(key, value);
  }

  static Future<String?> getStringItem(String key) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(key) &&
        sharedPreferences.getString(key) != null) {
      return sharedPreferences.getString(key);
    }
    return null;
  }

  static storeBoolItem(String key, bool value) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setBool(key, value);
  }

  static Future<bool?> getBoolItem(String key) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(key) &&
        sharedPreferences.getBool(key) != null) {
      return sharedPreferences.getBool(key);
    }
    return null;
  }

  static Future<bool> removeStringItem(String key) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(key) &&
        sharedPreferences.getString(key) != null) {
      return sharedPreferences.remove(key);
    }
    return false;
  }

  static Future<bool> reset() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.clear();
  }
}
