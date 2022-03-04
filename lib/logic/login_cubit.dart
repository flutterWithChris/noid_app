import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:noid_app/data/Model/woo_controller.dart';
import 'package:woocommerce/models/customer.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState(isLoggedIn: false));

  void loginAttempt(String username, String password) async {
    var _currentUser = await wooController.loginCustomer(
        username: username, password: password);
    if (_currentUser is WooCustomer) {
      emit(LoginState(isLoggedIn: true));
      print("Logged In **");
    } else if (_currentUser != WooCustomer) {
      emit(LoginState(isLoggedIn: false));
      print("Not Logged In!");
    }
  }

  void showLoadingDialog() {}
}
