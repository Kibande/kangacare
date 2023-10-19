import 'package:dartz/dartz.dart';
import '../error/failures.dart';

class SignedIntInputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      int integer = int.parse(str);
      if (integer < 0) throw const FormatException();
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}
