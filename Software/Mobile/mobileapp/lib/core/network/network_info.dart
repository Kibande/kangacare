import 'package:flutter/material.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Object connectionChecker;

  NetworkInfoImpl({required this.connectionChecker});

  @override
  //Future<bool> get isConnected => connectionChecker.hasConnection;
  //Future<bool> get isConnected => Future.value(false);
  Future<bool> get isConnected async {
    await Future.delayed(const Duration(seconds: 0));
    return true;
  }
}
