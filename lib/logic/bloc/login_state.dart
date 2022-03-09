part of 'login_bloc.dart';

class LoginInit extends LoginState {}

class LoginState {
  final String username;
  final String password;
  final FormSubmissionStatus formStatus;
  LoginState({
    this.username = "",
    this.password = "",
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith({
    String? username,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return LoginState(
      username: this.username,
      password: this.password,
      formStatus: this.formStatus,
    );
  }
}

class LoginLoading extends LoginState{}

class LoginSuccess extends LoginState{}

class LoginFail extends LoginState{}
