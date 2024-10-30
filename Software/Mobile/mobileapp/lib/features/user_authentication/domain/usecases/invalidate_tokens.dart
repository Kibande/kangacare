import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/user_authentication_repository.dart';

class InvalidateTokens implements UseCase<bool, InvalidateTokensParams> {
  final UserAutheniticationRepository repository;

  InvalidateTokens({required this.repository});

  @override
  Future<Either<Failure, bool>> call(InvalidateTokensParams params) async {
    return await repository.invalidateTokens(
        accountPassword: params.accountPassword);
  }
}

class InvalidateTokensParams extends Equatable {
  final String accountPassword;

  const InvalidateTokensParams({
    required this.accountPassword,
  });

  @override
  List<Object?> get props => [
        accountPassword,
      ];
}
