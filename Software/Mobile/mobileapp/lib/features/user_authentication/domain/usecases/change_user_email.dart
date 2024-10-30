import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/user_authentication_repository.dart';

class ChangeUserEmail implements UseCase<bool, ChangeUserEmailParams> {
  final UserAutheniticationRepository repository;

  ChangeUserEmail({required this.repository});

  @override
  Future<Either<Failure, bool>> call(ChangeUserEmailParams params) async {
    return await repository.changeUserEmail(
        newUserEmail: params.newUserEmail,
        accountPassword: params.accountPassword);
  }
}

class ChangeUserEmailParams extends Equatable {
  final String newUserEmail;
  final String accountPassword;

  const ChangeUserEmailParams({
    required this.newUserEmail,
    required this.accountPassword,
  });

  @override
  List<Object?> get props => [
        newUserEmail,
        accountPassword,
      ];
}
