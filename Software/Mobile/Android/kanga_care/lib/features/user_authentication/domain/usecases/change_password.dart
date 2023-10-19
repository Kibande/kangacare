import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/user_authentication_repository.dart';

class ChangePassword implements UseCase<bool, ChangePasswordParams> {
  final UserAutheniticationRepository repository;

  ChangePassword({required this.repository});

  @override
  Future<Either<Failure, bool>> call(ChangePasswordParams params) async {
    return await repository.changePassword(
        newPassword: params.newPassword, oldPassword: params.oldPassword);
  }
}

class ChangePasswordParams extends Equatable {
  final String newPassword;
  final String oldPassword;

  const ChangePasswordParams({
    required this.newPassword,
    required this.oldPassword,
  });

  @override
  List<Object?> get props => [
        newPassword,
        oldPassword,
      ];
}
