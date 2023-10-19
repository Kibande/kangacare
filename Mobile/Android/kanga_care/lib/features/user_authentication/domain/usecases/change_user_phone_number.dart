import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/user_authentication_repository.dart';

class ChangeUserPhoneNumber
    implements UseCase<bool, ChangeUserPhoneNumberParams> {
  final UserAutheniticationRepository repository;

  ChangeUserPhoneNumber({required this.repository});

  @override
  Future<Either<Failure, bool>> call(ChangeUserPhoneNumberParams params) async {
    return await repository.changeUserPhoneNumber(
        newUserPhoneNumber: params.newUserPhoneNumber,
        accountPassword: params.accountPassword);
  }
}

class ChangeUserPhoneNumberParams extends Equatable {
  final String newUserPhoneNumber;
  final String accountPassword;

  const ChangeUserPhoneNumberParams({
    required this.newUserPhoneNumber,
    required this.accountPassword,
  });

  @override
  List<Object?> get props => [
        newUserPhoneNumber,
        accountPassword,
      ];
}
