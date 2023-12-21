import 'package:equatable/equatable.dart';

abstract class CountStatus extends Equatable {}

class CountStatusCompleted extends CountStatus {
  final int count;

  CountStatusCompleted(this.count);

  @override
  List<Object?> get props => [count];
}

class CountStatusError extends CountStatus {
  final String message;

  CountStatusError(this.message);

  @override
  List<Object?> get props => [message];
}
