import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

import './app_themes.dart';

class AppState extends ChangeNotifier {
  AppState() {
    findTheme();
    findLaunchStatus();
  }

  bool _isFirstlaunch = true;
  Future findTheme() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.getBool("dark") ?? false) {
      setDark();
    } else {
      setLight();
    }
  }

  Future findLaunchStatus() async {
    final pref = await SharedPreferences.getInstance();
    final launchStatus = pref.getBool("isFirstlaunch") ?? true;
    _isFirstlaunch = launchStatus;
  }

  bool get getLaunchStatus => _isFirstlaunch;

  Future<void> setisFirstLaunchStatus({required bool status}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isFirstlaunch", status);
  }

  Future<void> setThemeIsDarkMode({required bool status}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("dark", status);
  }

  ThemeData currentTheme = CustomAppThemes.lightTheme;

  void setDark() {
    currentTheme = CustomAppThemes.darkTheme;
    notifyListeners();
    setThemeIsDarkMode(status: true);
  }

  void setLight() {
    currentTheme = CustomAppThemes.lightTheme;
    notifyListeners();
    setThemeIsDarkMode(status: false);
  }

  void toggleTheme() {
    if (currentTheme == CustomAppThemes.darkTheme) {
      currentTheme = CustomAppThemes.lightTheme;
      setThemeIsDarkMode(status: false);
    } else {
      setThemeIsDarkMode(status: true);
      currentTheme = CustomAppThemes.darkTheme;
    }
    notifyListeners();
  }

  Future resetAppStates() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  ThemeData get getCurrentTheme => currentTheme;
}
