import 'dart:convert';

import 'package:news/core/model/user.dart';
import 'package:news/core/services/encrypt/encrypt_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final _keyUsers = 'users';
  static final _keyUser = 'user';
  static final _keyLogged = 'logged';
  static final _encrypt = EncryptService();

  static Future<bool> register(User user) async {
    final prefs = await SharedPreferences.getInstance();
    var listUser = await _getUsers();
    var isPresent = _isPresent(listUser, user.email);
    if (isPresent) {
      return false;
    }
    user.password = _encrypt.encode(user.password);
    listUser.add(user);
    var listUserStr = listUser
        .map((user) => jsonEncode(user.toJson()))
        .toList();
    prefs.setStringList(_keyUsers, listUserStr);
    prefs.setBool(_keyLogged, true);
    return true;
  }

  static Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    var listUser = await _getUsers();
    var user = _getUser(listUser, email);
    if (user == null) {
      return false;
    }
    var isCorrect = _encrypt.match(password, user.password);
    if (isCorrect) {
      prefs.setString(_keyUser, jsonEncode(user.toJson()));
      return true;
    }
    return false;
  }

  static Future<bool> isLogged() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyLogged) ?? false;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_keyUsers);
    prefs.setBool(_keyLogged, false);
  }

  static bool _isPresent(List<User> list, String email) {
    for (var user in list) {
      if (user.email == email) {
        return true;
      }
    }
    return false;
  }

  static User? _getUser(List<User> list, String email) {
    for (var user in list) {
      if (user.email == email) {
        return user;
      }
    }
    return null;
  }

  static Future<List<User>> _getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> listUserStr = prefs.getStringList(_keyUsers) ?? [];
    return listUserStr.map((json) => User.fromJson(jsonDecode(json))).toList();
  }
}
