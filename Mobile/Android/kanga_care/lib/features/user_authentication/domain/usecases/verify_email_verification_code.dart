import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/user_authentication_repository.dart';

class VerifyEmailVerificationCode
    implements UseCase<bool, VerifyEmailVerificationCodeParams> {
  final UserAutheniticationRepository repository;

  VerifyEmailVerificationCode({required this.repository});

  @override
  Future<Either<Failure, bool>> call(
      VerifyEmailVerificationCodeParams params) async {
    return await repository.verifyEmailVerificationCode(code: params.code);
  }
}

class VerifyEmailVerificationCodeParams extends Equatable {
  final String code;

  const VerifyEmailVerificationCodeParams({
    required this.code,
  });

  @override
  List<Object?> get props => [
        code,
      ];
}
