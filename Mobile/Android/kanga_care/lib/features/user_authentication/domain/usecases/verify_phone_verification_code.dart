import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/user_authentication_repository.dart';

class VerifyPhoneVerificationCode
    implements UseCase<bool, VerifyPhoneVerificationCodeParams> {
  final UserAutheniticationRepository repository;

  VerifyPhoneVerificationCode({required this.repository});

  @override
  Future<Either<Failure, bool>> call(
      VerifyPhoneVerificationCodeParams params) async {
    return await repository.verifyPhoneVerificationCode(code: params.code);
  }
}

class VerifyPhoneVerificationCodeParams extends Equatable {
  final String code;

  const VerifyPhoneVerificationCodeParams({
    required this.code,
  });

  @override
  List<Object?> get props => [
        code,
      ];
}
