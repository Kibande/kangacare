import 'package:dartz/dartz.dart';
import '../error/failures.dart';
import 'package:intl/intl.dart';

class CustomDateTimeFunctions {
  Either<Failure, String> ageText({required DateTime? time}) {
    try {
      if (time == null) {
        return const Right('');
      }

      return Right(
          time.isAfter(DateTime.now().subtract(const Duration(hours: 24)))
              ? DateFormat.jm().format(time)
              : time.isAfter(DateTime.now().subtract(const Duration(hours: 48)))
                  ? 'yesterday'
                  : DateFormat('d/M/y').format(time));
    } on Exception {
      return Left(InvalidInputFailure());
    }
  }

  Either<Failure, String> futureAgeText({required DateTime? time}) {
    try {
      if (time == null) {
        return const Right('');
      }

      return Right(time.isBefore(DateTime.now().add(const Duration(hours: 24)))
          ? "Today at ${DateFormat.jm().format(time)}"
          : time.isBefore(DateTime.now().add(const Duration(hours: 48)))
              ? 'Tommorrow'
              : DateFormat('d/M/y').format(time));
    } on Exception {
      return Left(InvalidInputFailure());
    }
  }

  Either<Failure, String> dateText({required DateTime? time}) {
    try {
      if (time == null) {
        return const Right('');
      }
      return Right(DateFormat('d/M/y').format(time));
    } on Exception {
      return Left(InvalidInputFailure());
    }
  }

  Either<Failure, String> timeText({required DateTime? time}) {
    try {
      if (time == null) {
        return const Right('');
      }

      return Right(DateFormat.jm().format(time));
    } on Exception {
      return Left(InvalidInputFailure());
    }
  }
}
