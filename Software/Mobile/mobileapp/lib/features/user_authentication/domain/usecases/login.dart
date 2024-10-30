import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/user.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/user_authentication_repository.dart';

class Login implements UseCase<User, LoginParams> {
  final UserAutheniticationRepository repository;

  Login({required this.repository});

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await repository.login(
        password: params.password, userEmailOrTel: params.userEmailOrTel);
  }
}

class LoginParams extends Equatable {
  final String userEmailOrTel;
  final String password;

  const LoginParams({
    required this.userEmailOrTel,
    required this.password,
  });

  @override
  List<Object?> get props => [
        userEmailOrTel,
        password,
      ];
}
