import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserLoginState extends Equatable {
  const UserLoginState([List props = const <dynamic>[]]) : super();

  @override
  List<Object?> get props => [props];
}

class NotLoggedState extends UserLoginState {}

class LoadingState extends UserLoginState {}

class LoggedState extends UserLoginState {
  final String login;

  LoggedState({required this.login}) : super([login]);
}

class ErrorState extends UserLoginState {
  final String message;

  ErrorState({required this.message}) : super([message]);
}
