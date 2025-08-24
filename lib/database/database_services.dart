import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseServices {
  DatabaseServices();
  Future<bool?> saveList(String key, List<String> list) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final result = await prefs.setStringList(key, list);
      return result;
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<List<String>?> getList(String key) async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      final result = await pref.getStringList(key);
      return result;
    } catch (e) {
      print(e);
    }
  }
}
