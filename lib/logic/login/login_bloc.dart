import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:noid_app/data/repository/user_repo.dart';
import 'package:noid_app/logic/login/validators.dart';
import 'dart:async';
import 'validators.dart';
import 'package:rxdart/rxdart.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with Validators {
  // * Email & Password Stream Controllers
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  // * UserRepo instance
  final UserRepo userRepo = UserRepo();

  // * Email Stream Getter & Setter + Validator
  Stream<String> get email => _email.stream.transform(validateEmail);
  Function(String) get changeEmail => _email.sink.add;

  // * Password Stream Getter & Setter + Validator
  Stream<String> get password => _password.stream.transform(validatePassword);
  Function(String) get changePassword => _password.sink.add;

  // * Combined Email & Password Stream (For Validation)
  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (email, password) => true);

  void dispose() {
    _email.close();
    _password.close();
  }

  _loginCheck() async {
    var loginResponse = await userRepo.isLoggedIn();
    if (loginResponse == true) {
      emit(LoginSuccess());
    }
  }

  LoginBloc() : super(LoginInitial()) {
    _loginCheck();

    on<LogOut>(((event, emit) => userRepo.logOut()));
    on<LoginRetry>(((event, emit) => emit(LoginInitial())));
    on<LoginSubmit>(((event, emit) async {
      emit(LoginLoading());
      bool loginResponse = false;
      // * Login Success Check
      await submitLogin(_email, _password, userRepo);
      await Future.delayed(const Duration(seconds: 1), (() async {
        loginResponse = await userRepo.isLoggedIn();
      }));
      loginResponse ? emit(LoginSuccess()) : emit(LoginFail());
      dispose();
    }));
  }
}

// * Login Submit Function
Future<bool> submitLogin(BehaviorSubject _email, BehaviorSubject _password,
    UserRepo userRepo) async {
  final validEmail = _email.value;
  final validPassword = _password.value;
  print(validEmail + " " + validPassword + " : attempted");
  var logResponse;

  // * Wordpress API Login
  await userRepo.loginUser(validEmail, validPassword);

  // * Login Response Bool
  logResponse = await userRepo.isLoggedIn();

  return logResponse;
}
