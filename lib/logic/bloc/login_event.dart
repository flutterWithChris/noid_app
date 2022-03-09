part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginUsernameChanged extends LoginEvent {
  final String username;
  LoginUsernameChanged({
    required this.username,
  });
}

class LoginPasswordChanged extends LoginEvent {
  final String password;
  LoginPasswordChanged({
    required this.password,
  });
}

class LoginSubmit extends LoginEvent {}

class LoginAttempt extends LoginEvent {}


