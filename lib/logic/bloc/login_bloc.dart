import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:get/get.dart' hide Rx;
import 'package:meta/meta.dart';
import 'package:noid_app/data/repository/user_repo.dart';
import 'package:noid_app/presentation/pages/home_page.dart';
import 'dart:async';
import 'validators.dart';
import 'package:rxdart/rxdart.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with Validators {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  final UserRepo userRepo = UserRepo();

  // Email Stream Getter & Setter
  Function(String) get changeEmail => _email.sink.add;
  Stream<String> get email => _email.stream.transform(validateEmail);

  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (email, password) => true);

  // Password Stream Getter & Setter
  Function(String) get changePassword => _password.sink.add;
  Stream<String> get password => _password.stream.transform(validatePassword);

  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LogOut>(((event, emit) => userRepo.logOut()));
    on<LoginRetry>(((event, emit) => emit(LoginInitial())));
    on<LoginSubmit>(((event, emit) async {
      emit(LoginLoading());
      print(state.toString());
      bool login = await submitLogin(_email, _password, userRepo);
      if (login == true) {
        emit(LoginSuccess());
        print(state);
      } else {
        emit(LoginFail());
      }
    }));

    void dispose() {
      _email.close();
      _password.close();
    }
  }
}

class LoginRetry extends LoginEvent {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFail extends LoginState {}

Future<bool> submitLogin(BehaviorSubject _email, BehaviorSubject _password,
    UserRepo userRepo) async {
  final validEmail = _email.value;
  final validPassword = _password.value;

  // TODO: Implement Wordpress API Login
  userRepo.loginUser(validEmail, validPassword);

  var logResponse = await userRepo.isLoggedIn();
  return logResponse;

  // * Also, download One Dark Pro on Laptop
}
