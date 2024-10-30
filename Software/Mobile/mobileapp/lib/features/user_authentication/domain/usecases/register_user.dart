import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/user.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/user_authentication_repository.dart';

class RegisterUser implements UseCase<User, RegisterUserParams> {
  final UserAutheniticationRepository repository;

  RegisterUser({required this.repository});

  @override
  Future<Either<Failure, User>> call(RegisterUserParams params) async {
    return await repository.registerUser(
        userFirstName: params.userFirstName,
        userSecondName: params.userSecondName,
        userEmail: params.userEmail,
        userTel: params.userTel,
        dpImage: params.dpImage,
        password: params.password);
  }
}

class RegisterUserParams extends Equatable {
  final String userFirstName;
  final String userSecondName;
  final String userEmail;
  final String userTel;
  final String dpImage;
  final String password;

  const RegisterUserParams(
      {required this.userFirstName,
      required this.userSecondName,
      required this.userEmail,
      required this.userTel,
      required this.dpImage,
      required this.password});

  @override
  List<Object?> get props => [
        userFirstName,
        userSecondName,
        userEmail,
        userTel,
        dpImage,
        password,
      ];
}
