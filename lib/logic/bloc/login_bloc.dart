import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:noid_app/data/Model/user.dart';
import 'package:noid_app/data/Model/woo_controller.dart';
import 'package:noid_app/data/providers/form_submission_status.dart';
import 'package:noid_app/data/providers/user_api.dart';
import 'package:noid_app/data/repository/user_repo.dart';
import 'package:noid_app/presentation/pages/home_page.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepo userRepo;
  void _loginCustomer(LoginAttempt event, Emitter<LoginState> emitter) async {
    var user = UserRepo().loginUser(
        LoginState().copyWith().username, LoginState().copyWith().password);
    if (user == User) {
      emit(LoginSuccess());
    } else {}
  }

  LoginBloc({required this.userRepo}) : super(LoginInit()) {
    on<LoginAttempt>((event, emit) {
      _loginCustomer(), LoginSubmit();
    },);
    on<LoginEvent>(((event, emit) async* {}));
    on<LoginUsernameChanged>(
      (event, emit) async* {
        yield state.copyWith(username: event.username);
      },
    );
    on<LoginPasswordChanged>(
      // ignore: void_checks
      (event, emit) async* {
        yield state.copyWith(password: event.password);
      },
    );
    on<LoginSubmit>((event, emit) async* {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        print("Bloc Log In Started");
        userRepo.loginUser(state.username, state.password);
        yield state.copyWith(formStatus: SubmitSuccess());
        print(state.copyWith().username + " Logged In**");

        Get.to(const HomePage());
      } catch (Exception, e) {
        yield state.copyWith(formStatus: SubmitFailed(e));
        print("**Login Failed**");
      }
    });
  }
}
