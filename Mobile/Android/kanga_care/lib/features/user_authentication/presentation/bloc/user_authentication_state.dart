import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

abstract class UserAuthenticationState extends Equatable {}

class Empty extends UserAuthenticationState {
  @override
  List<Object?> get props => [];
}

class Loading extends UserAuthenticationState {
  @override
  List<Object?> get props => [];
}

class Loaded extends UserAuthenticationState {
  final User? user;
  final String? stringResponse;
  final bool? boolResponse;

  Loaded({this.user, this.stringResponse, this.boolResponse});

  @override
  List<Object?> get props => [user, stringResponse, boolResponse];
}

class Error extends UserAuthenticationState {
  final String? errorMessage;
  Error({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
