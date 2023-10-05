import 'package:flutter/material.dart';
import 'package:subspace/utils/user_pref.dart';

class ThemeProvider extends ChangeNotifier {
  bool _darkTheme = true;

  get getDarkTheme {
    return _darkTheme;
  }

  Future<bool> loadTheme() async {
    _darkTheme = UserPrefs.getDarkTheme() ?? true;
    if (UserPrefs.getDarkTheme() == null) {
      await UserPrefs.setDarkTheme(_darkTheme);
    }
    notifyListeners();
    return _darkTheme;
  }

  Future<void> toggleTheme() async {
    _darkTheme = !_darkTheme;
    await UserPrefs.setDarkTheme(_darkTheme);
    notifyListeners();
  }
}
