import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  static SharedPreferences? _preferences;

  static const String _keyBlogs = "blogs";
  static const String _keyIsFavorite = "isFavorite";
  static const String _keyDarkTheme = "isdark";

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setBlogs(String value) async =>
      await _preferences!.setString(_keyBlogs, value);

  static Future setFavorite(List<String> value) async =>
      await _preferences!.setStringList(_keyIsFavorite, value);

  static Future setDarkTheme(bool value) async =>
      await _preferences!.setBool(_keyDarkTheme, value);

  static String? getBlogs() => _preferences!.getString(_keyBlogs);
  static List<String>? getFavorite() =>
      _preferences!.getStringList(_keyIsFavorite);

  static bool? getDarkTheme() => _preferences!.getBool(_keyDarkTheme);
}
