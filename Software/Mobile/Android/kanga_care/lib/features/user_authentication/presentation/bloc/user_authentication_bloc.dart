import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/change_password.dart';
import '../../domain/usecases/change_profile_pic.dart';
import '../../domain/usecases/change_user_email.dart';
import '../../domain/usecases/change_user_names.dart';
import '../../domain/usecases/change_user_phone_number.dart';
import '../../domain/usecases/delete_account.dart';
import '../../domain/usecases/invalidate_tokens.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/me.dart';
import '../../domain/usecases/register_user.dart';
import '../../domain/usecases/send_email_verification.dart';
import '../../domain/usecases/send_phone_verification_code.dart';
import '../../domain/usecases/verify_email_verification_code.dart';
import '../../domain/usecases/verify_phone_verification_code.dart';
import '../../presentation/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAuthenticationBloc
    extends Bloc<UserAuthenticationEvent, UserAuthenticationState> {
  final ChangePassword changePassword;
  final ChangeProfilePic changeProfilePic;
  final ChangeUserEmail changeUserEmail;
  final ChangeUserNames changeUserNames;
  final ChangeUserPhoneNumber changeUserPhoneNumber;
  final DeleteAccount deleteAccount;
  final InvalidateTokens invalidateTokens;
  final Login login;
  final Logout logout;
  final Me me;

  final RegisterUser registerUser;
  final SendEmailVerificationCode sendEmailVerificationCode;
  final SendPhoneVerificationCode sendPhoneVerificationCode;
  final VerifyEmailVerificationCode verifyEmailVerificationCode;
  final VerifyPhoneVerificationCode verifyPhoneVerificationCode;
  UserAuthenticationBloc({
    required this.changePassword,
    required this.changeProfilePic,
    required this.changeUserEmail,
    required this.changeUserNames,
    required this.changeUserPhoneNumber,
    required this.deleteAccount,
    required this.invalidateTokens,
    required this.login,
    required this.logout,
    required this.me,
    required this.registerUser,
    required this.sendEmailVerificationCode,
    required this.sendPhoneVerificationCode,
    required this.verifyEmailVerificationCode,
    required this.verifyPhoneVerificationCode,
  }) : super(Empty()) {
    on<UserAuthenticationEvent>((
      UserAuthenticationEvent event,
      Emitter<UserAuthenticationState> emit,
    ) async {
      if (event is ChangePasswordEvent) {
        emit(Loading());
        final failureOrBoolen = await changePassword(ChangePasswordParams(
            newPassword: event.newPassword, oldPassword: event.oldPassword));
        await for (final loadedState
            in _eitherLoadedOrErrorStateForBool(failureOrBoolen)) {
          emit(loadedState);
        }
      } else if (event is ChangeProfilePicEvent) {
        emit(Loading());
        final failureOrBoolen = await changeProfilePic(
            ChangeProfilePicParams(profilePicUrl: event.profilePicUrl));
        await for (final loadedState
            in _eitherLoadedOrErrorStateForBool(failureOrBoolen)) {
          emit(loadedState);
        }
      } else if (event is ChangeUserEmailEvent) {
        emit(Loading());
        final failureOrBoolen = await changeUserEmail(ChangeUserEmailParams(
            newUserEmail: event.newUserEmail,
            accountPassword: event.accountPassword));
        await for (final loadedState
            in _eitherLoadedOrErrorStateForBool(failureOrBoolen)) {
          emit(loadedState);
        }
      } else if (event is ChangeUserNamesEvent) {
        emit(Loading());
        final failureOrBoolen = await changeUserNames(ChangeUserNamesParams(
            newFirstUserName: event.newFirstUserName,
            newSecondUserName: event.newSecondUserName,
            accountPassword: event.accountPassword));
        await for (final loadedState
            in _eitherLoadedOrErrorStateForBool(failureOrBoolen)) {
          emit(loadedState);
        }
      } else if (event is ChangeUserPhoneNumberEvent) {
        emit(Loading());
        final failureOrBoolen = await changeUserPhoneNumber(
            ChangeUserPhoneNumberParams(
                newUserPhoneNumber: event.newUserPhoneNumber,
                accountPassword: event.accountPassword));
        await for (final loadedState
            in _eitherLoadedOrErrorStateForBool(failureOrBoolen)) {
          emit(loadedState);
        }
      } else if (event is DeleteAccountEvent) {
        emit(Loading());
        final failureOrBoolen = await deleteAccount(
            DeleteAccountParams(accountPassword: event.accountPassword));
        await for (final loadedState
            in _eitherLoadedOrErrorStateForBool(failureOrBoolen)) {
          emit(loadedState);
        }
      } else if (event is InvalidateTokensEvent) {
        emit(Loading());
        final failureOrBoolen = await invalidateTokens(
            InvalidateTokensParams(accountPassword: event.accountPassword));
        await for (final loadedState
            in _eitherLoadedOrErrorStateForBool(failureOrBoolen)) {
          emit(loadedState);
        }
      } else if (event is LoginEvent) {
        emit(Loading());
        final failureOrUser = await login(LoginParams(
            password: event.password, userEmailOrTel: event.userEmailOrTel));
        await for (final loadedState
            in _eitherLoadedOrErrorStateForUser(failureOrUser)) {
          emit(loadedState);
        }
      } else if (event is LogoutEvent) {
        emit(Loading());
        final failureOrBoolen = await logout(NoParams());
        await for (final loadedState
            in _eitherLoadedOrErrorStateForBool(failureOrBoolen)) {
          emit(loadedState);
        }
      } else if (event is MeEvent) {
        emit(Loading());
        final failureOrUser = await me(NoParams());
        await for (final loadedState
            in _eitherLoadedOrErrorStateForUser(failureOrUser)) {
          emit(loadedState);
        }
      } else if (event is RegisterUserEvent) {
        emit(Loading());
        final failureOrUser = await registerUser(RegisterUserParams(
            userFirstName: event.userFirstName,
            userSecondName: event.userSecondName,
            userEmail: event.userEmail,
            userTel: event.userTel,
            dpImage: event.dpImage,
            password: event.password));
        await for (final loadedState
            in _eitherLoadedOrErrorStateForUser(failureOrUser)) {
          emit(loadedState);
        }
      } else if (event is SendEmailVerificationEvent) {
        emit(Loading());
        final failureOrBoolen = await sendEmailVerificationCode(NoParams());
        await for (final loadedState
            in _eitherLoadedOrErrorStateForBool(failureOrBoolen)) {
          emit(loadedState);
        }
      } else if (event is SendPhoneVerificationEvent) {
        emit(Loading());
        final failureOrBoolen = await sendPhoneVerificationCode(NoParams());
        await for (final loadedState
            in _eitherLoadedOrErrorStateForBool(failureOrBoolen)) {
          emit(loadedState);
        }
      } else if (event is VerifyEmailVerificationCodeEvent) {
        emit(Loading());
        final failureOrBoolen = await verifyEmailVerificationCode(
            VerifyEmailVerificationCodeParams(code: event.code));
        await for (final loadedState
            in _eitherLoadedOrErrorStateForBool(failureOrBoolen)) {
          emit(loadedState);
        }
      } else if (event is VerifyPhoneVerificationCodeEvent) {
        emit(Loading());
        final failureOrBoolen = await verifyPhoneVerificationCode(
            VerifyPhoneVerificationCodeParams(code: event.code));
        await for (final loadedState
            in _eitherLoadedOrErrorStateForBool(failureOrBoolen)) {
          emit(loadedState);
        }
      }
    });
  }

  Stream<UserAuthenticationState> _eitherLoadedOrErrorStateForUser(
      Either<Failure, User> failureOrUser) async* {
    yield failureOrUser.fold((failure) => Error(errorMessage: failure.message),
        (user) => Loaded(user: user, stringResponse: null, boolResponse: null));
  }

  Stream<UserAuthenticationState> _eitherLoadedOrErrorStateForBool(
      Either<Failure, bool> failureOrBoolenResponse) async* {
    yield failureOrBoolenResponse.fold(
        (failure) => Error(errorMessage: failure.message),
        (boolenResponse) => Loaded(
            user: null, stringResponse: null, boolResponse: boolenResponse));
  }
}
