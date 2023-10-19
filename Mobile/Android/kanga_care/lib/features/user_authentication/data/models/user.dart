// ignore_for_file: overridden_fields

import '../../domain/entities/user.dart';

// ignore: must_be_immutable
class UserModel extends User {
  @override
  final String userFirstName;
  @override
  final String userSecondName;
  @override
  final String userEmail;
  @override
  final String userTel;
  @override
  final String dpImage;
  @override
  final bool phoneVerified;
  @override
  final bool emailVerified;

  UserModel({
    required this.userFirstName,
    required this.userSecondName,
    required this.userEmail,
    required this.userTel,
    required this.dpImage,
    required this.phoneVerified,
    required this.emailVerified,
  }) : super(
            userFirstName: userFirstName,
            userSecondName: userSecondName,
            userEmail: userEmail,
            userTel: userTel,
            dpImage: dpImage,
            phoneVerified: phoneVerified,
            emailVerified: emailVerified);

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
        userFirstName: jsonData['userFirstName'],
        userSecondName: jsonData['userSecondName'],
        userEmail: jsonData['userEmail'],
        userTel: jsonData['userTel'],
        dpImage: jsonData['dpImage'],
        phoneVerified: jsonData['phoneVerified'],
        emailVerified: jsonData['emailVerified']);
  }

  Map<String, dynamic> toJson() {
    return {
      "userFirstName": userFirstName,
      "userSecondName": userSecondName,
      "userEmail": userEmail,
      "userTel": userTel,
      "dpImage": dpImage,
      "phoneVerified": phoneVerified,
      "emailVerified": emailVerified
    };
  }
}
