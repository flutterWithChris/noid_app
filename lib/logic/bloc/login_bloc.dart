import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:async';
import 'validators.dart';
import 'package:rxdart/rxdart.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with Validators {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  // Email Stream Getter & Setter
  Function(String) get changeEmail => _email.sink.add;
  Stream<String> get email => _email.stream.transform(validateEmail);

  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (email, password) => true);

  // Password Stream Getter & Setter
  Function(String) get changePassword => _password.sink.add;
  Stream<String> get password => _password.stream.transform(validatePassword);

  submit() {
    final validEmail = _email.value;
    final validPassword = _password.value;

    // TODO: Implement Wordpress API Login
    // * Also, download One Dark Pro on Laptop
  }

  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });

    void dispose() {
      _email.close();
      _password.close();
    }
  }
}
