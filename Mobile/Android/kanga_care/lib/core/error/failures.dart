import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String? message = 'An Defined faliure';

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [super.message];
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => [super.message];
}

class InvalidInputFailure extends Failure {
  @override
  List<Object?> get props => [super.message];
}
