import 'dart:async';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CredentialsProvider {
  CredentialsProvider() {
    findTokens();
  }

  static String? _accessToken;
  static String? _refreshToken;

  static Future findTokens() async {
    final pref = await SharedPreferences.getInstance();
    final accessTokenFromDevice = pref.getString("accessToken");
    final refreshTokenFromDevice = pref.getString("refreshToken");

    _accessToken = accessTokenFromDevice;
    _refreshToken = refreshTokenFromDevice;
  }

  static Future<void> setnewDeviceAccessToken(
      {required String? newAccessToken}) async {
    debugPrint(newAccessToken);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("accessToken", newAccessToken ?? "");
  }

  static Future<void> setnewDeviceRefreshToken(
      {required String? newRefreshToken}) async {
    debugPrint(newRefreshToken);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("refreshToken", newRefreshToken ?? "");
  }

  static String? get getAccesToken => _accessToken;
  static String? get getRefreshToken => _refreshToken;

  static void deletedAllTokens() {
    setnewDeviceAccessToken(newAccessToken: null);
    setnewDeviceRefreshToken(newRefreshToken: null);
  }
}
