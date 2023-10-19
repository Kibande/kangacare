import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/user_authentication_repository.dart';

class SendPhoneVerificationCode implements UseCase<bool, NoParams> {
  final UserAutheniticationRepository repository;

  SendPhoneVerificationCode({required this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.sendPhoneVerificationCode();
  }
}
