import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/user_authentication_repository.dart';

class ChangeUserNames implements UseCase<bool, ChangeUserNamesParams> {
  final UserAutheniticationRepository repository;

  ChangeUserNames({required this.repository});

  @override
  Future<Either<Failure, bool>> call(ChangeUserNamesParams params) async {
    return await repository.changeUserNames(
        newFirstUserName: params.newFirstUserName,
        newSecondUserName: params.newSecondUserName,
        accountPassword: params.accountPassword);
  }
}

class ChangeUserNamesParams extends Equatable {
  final String newFirstUserName;
  final String newSecondUserName;
  final String accountPassword;

  const ChangeUserNamesParams({
    required this.newFirstUserName,
    required this.newSecondUserName,
    required this.accountPassword,
  });

  @override
  List<Object?> get props =>
      [newFirstUserName, newSecondUserName, accountPassword];
}
