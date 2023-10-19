import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../../../../core/error/failures.dart';

abstract class UserAutheniticationRepository {
  Future<Either<Failure, bool>> changePassword(
      {required String newPassword, required String oldPassword});

  Future<Either<Failure, bool>> changeProfilePic(
      {required String profilePicUrl});

  Future<Either<Failure, bool>> changeUserEmail(
      {required String newUserEmail, required String accountPassword});

  Future<Either<Failure, bool>> changeUserNames(
      {required String newFirstUserName,
      required String newSecondUserName,
      required String accountPassword});

  Future<Either<Failure, bool>> changeUserPhoneNumber(
      {required String newUserPhoneNumber, required String accountPassword});

  Future<Either<Failure, bool>> deleteAccount(
      {required String accountPassword});

  Future<Either<Failure, bool>> invalidateTokens(
      {required String accountPassword});

  Future<Either<Failure, User>> login(
      {required String userEmailOrTel, required String password});

  Future<Either<Failure, bool>> logout();

  Future<Either<Failure, User>> me();

  Future<Either<Failure, User>> registerUser(
      {required String userFirstName,
      required String userSecondName,
      required String userEmail,
      required String userTel,
      required String dpImage,
      required String password});

  Future<Either<Failure, bool>> sendEmailVerificationCode();

  Future<Either<Failure, bool>> sendPhoneVerificationCode();

  Future<Either<Failure, bool>> verifyEmailVerificationCode(
      {required String code});

  Future<Either<Failure, bool>> verifyPhoneVerificationCode(
      {required String code});
}
