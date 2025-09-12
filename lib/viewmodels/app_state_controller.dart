import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/sharedpreferences_service.dart';

class AppStateController extends GetxController {
  final SharedPreferencesService _prefsService;

  AppStateController(this._prefsService);
  SharedPreferencesService get prefsService => _prefsService;

  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  static const _themeKey = 'theme_mode';
  final RxString sgst = ''.obs;
  final RxString cgst = ''.obs;

  void setSgst(String value) => sgst.value = value;
  void setCgst(String value) => cgst.value = value;

  Future<void> initialize() async {
    final savedTheme = _prefsService.getString(_themeKey);
    if (savedTheme == 'light') {
      themeMode.value = ThemeMode.light;
    } else if (savedTheme == 'dark') {
      themeMode.value = ThemeMode.dark;
    } else {
      themeMode.value = ThemeMode.system;
    }
  }

  void toggleTheme(bool isDark) {
    themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
    _prefsService.setString(_themeKey, isDark ? 'dark' : 'light');
  }

}
