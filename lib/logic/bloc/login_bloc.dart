import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:async';
import 'validators.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with Validators {
  final _email = StreamController<String>();
  final _password = StreamController<String>();

  // Email Stream Getter & Setter
  Function(String) get changeEmail => _email.sink.add;
  Stream<String> get email => _email.stream.transform(validateEmail);

  // Password Stream Getter & Setter
  Function(String) get changePassword => _password.sink.add;
  Stream<String> get password => _password.stream.transform(validatePassword);

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