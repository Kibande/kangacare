import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/user_authentication_repository.dart';

class Me implements UseCase<User, NoParams> {
  final UserAutheniticationRepository repository;

  Me({required this.repository});

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.me();
  }
}
