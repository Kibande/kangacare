class CustomeServerException implements Exception {
  final String? msg;
  CustomeServerException({required this.msg});
}

class CustomeCacheException implements Exception {}
