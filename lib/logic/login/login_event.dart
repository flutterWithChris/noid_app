part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginSubmit extends LoginEvent {}


class LogOut extends LoginEvent {}

class LoginRetry extends LoginEvent {}
