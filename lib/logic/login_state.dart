part of 'login_cubit.dart';

class LoginState {
  bool isLoggedIn;
  LoginState({
    required this.isLoggedIn,
  });
}

class LoginFailed extends LoginState {
  LoginFailed({required bool isLoggedIn}) : super(isLoggedIn: isLoggedIn);
}

class LoginSuccess extends LoginState {
  LoginSuccess({required bool isLoggedIn}) : super(isLoggedIn: isLoggedIn);
}

class LoginLoading extends LoginState {
  LoginLoading({required bool isLoggedIn}) : super(isLoggedIn: isLoggedIn);
}

void showLoadingDialog(BuildContext context) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text('Logging In...')));
}

void showErrorDialog(BuildContext context) {}

void showSuccessDialog(BuildContext context) {}
