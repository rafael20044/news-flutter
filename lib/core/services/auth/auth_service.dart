import 'dart:convert';

import 'package:news/core/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final keyUser = 'user';
  static final keyLogged = 'logged';

  static Future<void> login(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(keyUser, jsonEncode(user.toJson()));
    prefs.setBool(keyLogged, true);
  }

  static Future<bool> isLogged() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyLogged) ?? false;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(keyUser);
    prefs.setBool(keyLogged, false);
  }

  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(keyUser);
    if (json == null) return null;
    return User.fromJson(jsonDecode(json));
  }
}
