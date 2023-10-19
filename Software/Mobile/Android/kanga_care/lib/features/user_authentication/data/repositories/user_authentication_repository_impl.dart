import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../../../core/error/failures.dart';
import '../../data/datasources/user_authentication_remote_data_source.dart';
import '../../domain/repositories/user_authentication_repository.dart';
import '../../../../core/error/custom_exceptions.dart';

class UserAuthenticationRepositoryImpl
    implements UserAutheniticationRepository {
  final UserAuthenticationRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserAuthenticationRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, bool>> changePassword(
      {required String newPassword, required String oldPassword}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.changePassword(
            newPassword: newPassword, oldPassword: oldPassword);
        return Right(result);
      } on CustomeServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> changeProfilePic(
      {required String profilePicUrl}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.changeProfilePic(
            profilePicUrl: profilePicUrl);
        return Right(result);
      } on CustomeServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> changeUserEmail(
      {required String newUserEmail, required String accountPassword}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.changeUserEmail(
            newUserEmail: newUserEmail, accountPassword: accountPassword);
        return Right(result);
      } on CustomeServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> changeUserNames(
      {required String newFirstUserName,
      required String newSecondUserName,
      required String accountPassword}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.changeUserNames(
            newFirstUserName: newFirstUserName,
            newSecondUserName: newSecondUserName,
            accountPassword: accountPassword);
        return Right(result);
      } on CustomeServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> changeUserPhoneNumber(
      {required String newUserPhoneNumber,
      required String accountPassword}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.changeUserPhoneNumber(
            newUserPhoneNumber: newUserPhoneNumber,
            accountPassword: accountPassword);
        return Right(result);
      } on CustomeServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteAccount(
      {required String accountPassword}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.deleteAccount(
            accountPassword: accountPassword);
        return Right(result);
      } on CustomeServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> invalidateTokens(
      {required String accountPassword}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.invalidateTokens(
            accountPassword: accountPassword);
        return Right(result);
      } on CustomeServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> login(
      {required String userEmailOrTel, required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.login(
            userEmailOrTel: userEmailOrTel, password: password);
        return Right(result);
      } on CustomeServerException catch (exception) {
        ServerFailure sf = ServerFailure();
        sf.message = exception.msg;
        return Left(sf);
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.logout();
        return Right(result);
      } on CustomeServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> me() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.me();
        return Right(result);
      } on CustomeServerException catch (exception) {
        ServerFailure sf = ServerFailure();
        sf.message = exception.msg;
        return Left(sf);
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> registerUser(
      {required String userFirstName,
      required String userSecondName,
      required String userEmail,
      required String userTel,
      required String dpImage,
      required String password}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.registerUser(
            userFirstName: userFirstName,
            userSecondName: userSecondName,
            userEmail: userEmail,
            userTel: userTel,
            dpImage: dpImage,
            password: password);
        return Right(result);
      } on CustomeServerException catch (exception) {
        ServerFailure sf = ServerFailure();
        sf.message = exception.msg;
        return Left(sf);
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> sendEmailVerificationCode() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.sendEmailVerificationCode();
        return Right(result);
      } on CustomeServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> sendPhoneVerificationCode() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.sendPhoneVerificationCode();
        return Right(result);
      } on CustomeServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
    ;
  }

  @override
  Future<Either<Failure, bool>> verifyEmailVerificationCode(
      {required String code}) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await remoteDataSource.verifyEmailVerificationCode(code: code);
        return Right(result);
      } on CustomeServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> verifyPhoneVerificationCode(
      {required String code}) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await remoteDataSource.verifyPhoneVerificationCode(code: code);
        return Right(result);
      } on CustomeServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
