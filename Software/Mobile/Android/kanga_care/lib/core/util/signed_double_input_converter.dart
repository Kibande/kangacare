import 'package:dartz/dartz.dart';
import '../error/failures.dart';

class SignedDoubleInputConverter {
  Either<Failure, double> stringToUnsignedDouble(String str) {
    try {
      double moneyAsdouble = double.parse(str);
      if (moneyAsdouble < 0) throw const FormatException();
      return Right(moneyAsdouble);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}
