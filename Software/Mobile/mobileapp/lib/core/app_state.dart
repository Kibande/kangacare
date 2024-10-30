import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import './app_themes.dart';

class AppState extends ChangeNotifier {
  AppState() {
    findTheme();
    findLaunchStatus();
    findBabyName();
    findBabyDOB();
    findBabyTOB();
    findBabyBirthWeight();
    findLastConnectedDeviceName();
    findParent1Name();
    findParent1Contact();
    findBabyID();
    findBabyPicUrl();
    findAdminPicUrl();
    findParent2Name();
    findParent2Contact();
  }

  bool _isFirstlaunch = true;
  String _babyName = "---";
  String _babyID = "---";
  String _babyDOB = "2000-01-01";
  String _babyTOB = "1:00 AM";
  String _babyBirthWeight = "00";
  String _parent1Name = "";
  String _parent1Contact = "";
  String _parent2Name = "";
  String _parent2Contact = "";
  String _lastConnectedDeviceName = "APP STATE DEFAULT";
  String _babyPicUrl = "assets/images/virtual/Default.png";
  String _adminPicUrl = "assets/images/virtual/Default.png";

  bool get getLaunchStatus => _isFirstlaunch;
  String get getBabyName => _babyName;
  String get getBabyDOB => _babyDOB;
  String get getBabyTOB => _babyTOB;
  String get getBabyBirthWeight => _babyBirthWeight;
  String get getBabyID => _babyID;

  String get getParent1Name => _parent1Name;
  String get getParent2Name => _parent2Name;

  String get getParent1Contact => _parent1Contact;
  String get getParent2Contact => _parent2Contact;
  String get getLastConnectedDeviceName => _lastConnectedDeviceName;
  String get getBabyPicUrl => _babyPicUrl;
  String get getAdminPicUrl => _adminPicUrl;

  Future<void> sendAppStateData() async {
    // Gather all your variables into a map
    Map<String, dynamic> data = {
      "babyID": _babyID,
      "babyName": _babyName,
      "babyDOB": _babyDOB,
      "babyTOB": _babyTOB,
      "babyBirthWeight": _babyBirthWeight,
      "parent1Name": _parent1Name,
      "parent1Contact": _parent1Contact,
      "parent2Name": _parent2Name,
      "parent2Contact": _parent2Contact,
      "lastConnectedDeviceName": _lastConnectedDeviceName,
      "babyPicUrl": _babyPicUrl,
    };

    try {
      print('Sent out: $data');
      // // Make the HTTP POST request
      // final response = await http.post(
      //   Uri.parse(
      //       'https://your-api-endpoint.com/submit'), // Replace with your actual API endpoint
      //   headers: {
      //     'Content-Type': 'application/json',
      //   },
      //   body: jsonEncode(data),
      // );

      // if (response.statusCode == 200) {
      //   // Handle success
      //   print('Data sent successfully');
      // } else {
      //   // Handle failure
      //   print('Failed to send data: ${response.statusCode}');
      // }
    } catch (e) {
      // Handle exceptions
      print('Error sending data: $e');
    }
  }

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

  Future findLastConnectedDeviceName() async {
    final pref = await SharedPreferences.getInstance();
    final lastConnectedDeviceName =
        pref.getString("lastConnectedDeviceName") ?? "NOT DE";
    _lastConnectedDeviceName = lastConnectedDeviceName;
  }

  Future findBabyPicUrl() async {
    final pref = await SharedPreferences.getInstance();
    final imageUrl = pref.getString("babyPicUrl") ?? _babyPicUrl;
    _babyPicUrl = imageUrl;
  }

  Future findAdminPicUrl() async {
    final pref = await SharedPreferences.getInstance();
    final imageUrl = pref.getString("adminPicUrl") ?? _babyPicUrl;
    _adminPicUrl = imageUrl;
  }

  Future findBabyName() async {
    final pref = await SharedPreferences.getInstance();
    final name = pref.getString("babyName") ?? _babyName;
    _babyName = name;
  }

  Future findBabyID() async {
    final pref = await SharedPreferences.getInstance();
    final id = pref.getString("babyID") ?? _babyName;
    _babyID = id;
  }

  Future findParent1Name() async {
    final pref = await SharedPreferences.getInstance();
    final name = pref.getString("parent1Name") ?? _parent1Name;
    _parent1Name = name;
  }

  Future findParent1Contact() async {
    final pref = await SharedPreferences.getInstance();
    final contact = pref.getString("parent1Contact") ?? _parent1Contact;
    _parent1Contact = contact;
  }

  Future findParent2Name() async {
    final pref = await SharedPreferences.getInstance();
    final name = pref.getString("parent2Name") ?? _parent2Name;
    _parent2Name = name;
  }

  Future findParent2Contact() async {
    final pref = await SharedPreferences.getInstance();
    final contact = pref.getString("parent2Contact") ?? _parent2Contact;
    _parent2Contact = contact;
  }

  Future findBabyDOB() async {
    final pref = await SharedPreferences.getInstance();
    final dOB = pref.getString("babyDOB") ?? _babyDOB;
    _babyDOB = dOB;
  }

  Future findBabyTOB() async {
    final pref = await SharedPreferences.getInstance();
    final tOB = pref.getString("babyTOB") ?? _babyTOB;
    _babyTOB = tOB;
  }

  Future findBabyBirthWeight() async {
    final pref = await SharedPreferences.getInstance();
    final babyBirthWeight =
        pref.getString("babyBirthWeight") ?? _babyBirthWeight;
    _babyBirthWeight = babyBirthWeight;
  }

  Future<void> setBabyID({required String id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("babyID", id);
    _babyID = id;
    notifyListeners();
  }

  Future<void> setBabyPicUrl({required String image_url}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("babyPicUrl", image_url);
    _babyPicUrl = image_url;
    notifyListeners();
  }

  Future<void> setAdminPicUrl({required String image_url}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("adminPicUrl", image_url);
    _adminPicUrl = image_url;
    notifyListeners();
  }

  Future<void> setBabyName({required String name}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("babyName", name);
    _babyName = name;
    notifyListeners();
  }

  Future<void> setLastConnectedDeviceName({required String advName}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("lastConnectedDeviceName", advName);
    _lastConnectedDeviceName = advName;
    notifyListeners();
  }

  Future<void> setParent1Name({required String name}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("parent1Name", name);
    _parent1Name = name;
    notifyListeners();
  }

  Future<void> setParent1Contact({required String contact}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("parent1Contact", contact);
    _parent1Contact = contact;
    notifyListeners();
  }

  Future<void> setParent2Name({required String name}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("parent2Name", name);
    _parent2Name = name;
    notifyListeners();
  }

  Future<void> setParent2Contact({required String contact}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("parent2Contact", contact);
    _parent2Contact = contact;
    notifyListeners();
  }

  Future<void> setBabyDOB({required String dOB}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("babyDOB", dOB);
    _babyDOB = dOB;
    notifyListeners();
  }

  Future<void> setBabyTOB({required String tOB}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("babyTOB", tOB);
    _babyTOB = tOB;
    notifyListeners();
  }

  Future<void> setBabyBirthWeight({required String babyBirthWeight}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("babyBirthWeight", babyBirthWeight);
    _babyBirthWeight = babyBirthWeight;
    notifyListeners();
  }

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

  void forcedNotifyListeners() {
    notifyListeners();
  }

  Future resetAppStates() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  ThemeData get getCurrentTheme => currentTheme;
}
