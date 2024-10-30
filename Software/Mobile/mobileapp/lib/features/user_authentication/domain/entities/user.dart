import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class User extends Equatable {
  String userFirstName;
  String userSecondName;
  String userEmail;
  String userTel;
  String dpImage;
  bool phoneVerified;
  bool emailVerified;

  User({
    required this.userFirstName,
    required this.userSecondName,
    required this.userEmail,
    required this.userTel,
    required this.dpImage,
    required this.phoneVerified,
    required this.emailVerified,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        userFirstName,
        userSecondName,
        userEmail,
        userTel,
        dpImage,
        phoneVerified,
        emailVerified
      ];
}
