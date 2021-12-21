import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  final _storage = GetStorage();
  final _key = 'ThemeMode';

  /// Get isDarkMode info from local storage and return ThemeMode
  ThemeMode get theme => _loadTheme() ? ThemeMode.dark : ThemeMode.light;

  bool get isDarkMode => _loadTheme();
  /// Load isDArkMode from local storage and if it's empty, returns false (that means default theme is light)
  bool _loadTheme() => _storage.read(_key) ?? false;

  /// Save isDarkMode to local storage
  void saveTheme(bool isDarkMode) => _storage.write(_key, isDarkMode);

  void darkTheme(){
    Get.changeThemeMode(ThemeMode.dark);
    saveTheme(true);
  }
  /// Switch theme and save to local storage
  void switchTheme() {
    Get.changeThemeMode(_loadTheme() ? ThemeMode.light : ThemeMode.dark);
    saveTheme(!_loadTheme());
  }
}
