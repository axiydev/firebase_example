import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static Future<bool> saveDataToLocal({String? token, String? key}) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key!, token!);
  }

  static Future<String?> getDataFromLocal({String? key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key!);
  }

  static Future<bool> deleteDataFromLocal({String? key}) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(key!);
  }
}
