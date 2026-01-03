import 'dart:convert';

import 'package:news/core/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final _keyUser = 'user';
  static final _keyLogged = 'logged';

  static Future<void> login(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_keyUser, jsonEncode(user.toJson()));
    prefs.setBool(_keyLogged, true);
  }

  static Future<bool> isLogged() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyLogged) ?? false;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_keyUser);
    prefs.setBool(_keyLogged, false);
  }

  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_keyUser);
    if (json == null) return null;
    return User.fromJson(jsonDecode(json));
  }
}
