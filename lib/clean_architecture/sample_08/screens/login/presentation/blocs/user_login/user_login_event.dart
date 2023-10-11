import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserLoginEvent extends Equatable {
  const UserLoginEvent([List props = const <dynamic>[]]) : super();

  @override
  List<Object?> get props => [props];
}

class CheckLoginStatusEvent extends UserLoginEvent {}

class LoginEvent extends UserLoginEvent {
  final String email;
  final String password;

  const LoginEvent(this.email, this.password);
}

class SkipLoginEvent extends UserLoginEvent {}
