import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/user_authentication_repository.dart';

class ChangeProfilePic implements UseCase<bool, ChangeProfilePicParams> {
  final UserAutheniticationRepository repository;

  ChangeProfilePic({required this.repository});

  @override
  Future<Either<Failure, bool>> call(ChangeProfilePicParams params) async {
    return await repository.changeProfilePic(
        profilePicUrl: params.profilePicUrl);
  }
}

class ChangeProfilePicParams extends Equatable {
  final String profilePicUrl;

  const ChangeProfilePicParams({
    required this.profilePicUrl,
  });

  @override
  List<Object?> get props => [profilePicUrl];
}
