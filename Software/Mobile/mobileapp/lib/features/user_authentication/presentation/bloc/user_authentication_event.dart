import 'package:equatable/equatable.dart';

abstract class UserAuthenticationEvent extends Equatable {}

class ChangePasswordEvent extends UserAuthenticationEvent {
  final String newPassword;
  final String oldPassword;

  ChangePasswordEvent({required this.newPassword, required this.oldPassword});

  @override
  List<Object?> get props => [newPassword, oldPassword];
}

class ChangeProfilePicEvent extends UserAuthenticationEvent {
  final String profilePicUrl;

  ChangeProfilePicEvent({required this.profilePicUrl});

  @override
  List<Object?> get props => [profilePicUrl];
}

class ChangeUserEmailEvent extends UserAuthenticationEvent {
  final String newUserEmail;
  final String accountPassword;

  ChangeUserEmailEvent(
      {required this.newUserEmail, required this.accountPassword});

  @override
  List<Object?> get props => [newUserEmail, accountPassword];
}

class ChangeUserNamesEvent extends UserAuthenticationEvent {
  final String newFirstUserName;
  final String newSecondUserName;
  final String accountPassword;

  ChangeUserNamesEvent(
      {required this.newFirstUserName,
      required this.newSecondUserName,
      required this.accountPassword});

  @override
  List<Object?> get props =>
      [newFirstUserName, newSecondUserName, accountPassword];
}

class ChangeUserPhoneNumberEvent extends UserAuthenticationEvent {
  final String newUserPhoneNumber;
  final String accountPassword;

  ChangeUserPhoneNumberEvent(
      {required this.newUserPhoneNumber, required this.accountPassword});

  @override
  List<Object?> get props => [newUserPhoneNumber, accountPassword];
}

class DeleteAccountEvent extends UserAuthenticationEvent {
  final String accountPassword;

  DeleteAccountEvent({required this.accountPassword});

  @override
  List<Object?> get props => [accountPassword];
}

class InvalidateTokensEvent extends UserAuthenticationEvent {
  final String accountPassword;

  InvalidateTokensEvent({required this.accountPassword});

  @override
  List<Object?> get props => [accountPassword];
}

class LoginEvent extends UserAuthenticationEvent {
  final String userEmailOrTel;
  final String password;

  LoginEvent({required this.userEmailOrTel, required this.password});

  @override
  List<Object?> get props => [userEmailOrTel, password];
}

class LogoutEvent extends UserAuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class MeEvent extends UserAuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class RegisterUserEvent extends UserAuthenticationEvent {
  final String userFirstName;
  final String userSecondName;
  final String userEmail;
  final String userTel;
  final String dpImage;
  final String password;

  RegisterUserEvent({
    required this.userFirstName,
    required this.userSecondName,
    required this.userEmail,
    required this.userTel,
    required this.dpImage,
    required this.password,
  });

  @override
  List<Object?> get props => throw [
        userFirstName,
        userSecondName,
        userEmail,
        userTel,
        dpImage,
        password
      ];
}

class SendEmailVerificationEvent extends UserAuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class SendPhoneVerificationEvent extends UserAuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class VerifyEmailVerificationCodeEvent extends UserAuthenticationEvent {
  final String code;

  VerifyEmailVerificationCodeEvent({required this.code});

  @override
  List<Object?> get props => [code];
}

class VerifyPhoneVerificationCodeEvent extends UserAuthenticationEvent {
  final String code;

  VerifyPhoneVerificationCodeEvent({required this.code});

  @override
  List<Object?> get props => [code];
}
