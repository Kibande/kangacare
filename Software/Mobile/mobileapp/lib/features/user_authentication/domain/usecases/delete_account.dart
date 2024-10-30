import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/user_authentication_repository.dart';

class DeleteAccount implements UseCase<bool, DeleteAccountParams> {
  final UserAutheniticationRepository repository;

  DeleteAccount({required this.repository});

  @override
  Future<Either<Failure, bool>> call(DeleteAccountParams params) async {
    return await repository.deleteAccount(
        accountPassword: params.accountPassword);
  }
}

class DeleteAccountParams extends Equatable {
  final String accountPassword;

  const DeleteAccountParams({
    required this.accountPassword,
  });

  @override
  List<Object?> get props => [
        accountPassword,
      ];
}
