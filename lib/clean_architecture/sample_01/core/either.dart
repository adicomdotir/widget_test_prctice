import 'package:meta/meta.dart';

typedef OnError<E> = void Function(E error);
typedef OnSuccess<S> = void Function(S success);

@sealed
abstract class Either<E, S> {
  const Either();

  E? getError();

  S? getSuccess();

  bool isError();

  bool isSuccess();

  void when({
    required OnError<E> error,
    required OnSuccess<S> success,
  });
}

@immutable
class Success<E, S> extends Either<E, S> {
  final S _success;

  const Success(this._success);

  @override
  E? getError() => null;

  @override
  S? getSuccess() => _success;

  @override
  bool isError() => false;

  @override
  bool isSuccess() => true;

  @override
  void when({required OnError<E> error, required OnSuccess<S> success}) {
    success(_success);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Success && other._success == _success;
  }

  @override
  int get hashCode => _success.hashCode;
}

@immutable
class Error<E, S> extends Either<E, S> {
  final E _error;

  const Error(this._error);

  @override
  E? getError() => _error;

  @override
  S? getSuccess() => null;

  @override
  bool isError() => true;

  @override
  bool isSuccess() => false;

  @override
  void when({required OnError<E> error, required OnSuccess<S> success}) {
    error(_error);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is Error && other._error == _error;
  }

  @override
  int get hashCode => _error.hashCode;
}

// @immutable
// class Unit {
//   const Unit._internal();

//   @override
//   String toString() => '()';
// }

// const unit = Unit._internal();