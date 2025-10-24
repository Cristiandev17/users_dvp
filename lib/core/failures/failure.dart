import 'package:users_dvp_app/core/constants/app_message.dart';

abstract class Failure {
  final String message;

  const Failure(this.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = AppMessage.unknownError]);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure([super.message = AppMessage.databaseError]);
}

class Result<T> {
  final T? value;
  final Failure? failure;

  const Result(this.value, this.failure);

  factory Result.success(T value) => Result(value, null);
  factory Result.failure(Failure failure) => Result(null, failure);

  bool get isSuccess => value != null;
  bool get isFailure => failure != null;
}
