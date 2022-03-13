import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:noid_app/data/Model/current_user.dart';
import 'package:noid_app/data/Model/woo_controller.dart';
import 'package:noid_app/data/repository/user_repo.dart';
import 'package:noid_app/logic/bloc/login_bloc.dart';
import 'package:noid_app/presentation/pages/home_page.dart';
import 'package:noid_app/presentation/widgets/main_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woocommerce/woocommerce.dart';

class LoginPage extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();

  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: _loginForm(),
      ),
    );
  }
}

class _loginForm extends StatelessWidget {
  const _loginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);

    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ? Add Noid Logo to center?
            _usernameField(loginBloc: loginBloc),
            _passwordField(loginBloc: loginBloc),
            _loginButton(loginBloc: loginBloc),
          ],
        ),
      ),
    );
  }
}

class _loginButton extends StatelessWidget {
  LoginBloc loginBloc;

  _loginButton({
    Key? key,
    required this.loginBloc,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return StreamBuilder(
      stream: loginBloc.submitValid,
      builder: (context, snapshot) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.lightGreen),
          onPressed: snapshot.hasData ? loginBloc.submit() : null,
          child: const Text('Log In'),
        );
      },
    );
  }
}

class _passwordField extends StatelessWidget {
  LoginBloc loginBloc;
  _passwordField({Key? key, required this.loginBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: loginBloc.stream,
      builder: (context, snapshot) {
        return TextField(
          obscureText: true,
          onChanged: (String value) {
            loginBloc.changePassword(value);
          },
          decoration: InputDecoration(
            errorText: snapshot.error.toString(),
            label: const Text('Password'),
            filled: true,
            fillColor: Colors.white,
          ),
        );
      },
    );
  }
}

class _usernameField extends StatelessWidget {
  LoginBloc loginBloc;
  _usernameField({
    Key? key,
    required this.loginBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);

    return StreamBuilder(
      stream: BlocProvider.of<LoginBloc>(context).stream,
      builder: (context, snapshot) {
        return TextField(
          keyboardType: TextInputType.emailAddress,
          onChanged: loginBloc.changeEmail,
          decoration: InputDecoration(
            errorText: snapshot.error.toString(),
            filled: true,
            fillColor: Colors.white,
            label: Text('Email Address'),
          ),
        );
      },
    );
  }
}

void showLoginAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: SizedBox(
        height: 150,
        child: Column(
          children: [
            const Text(
              "Looks like somethings not quite right.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () => Get.back(),
              child: const Text("Try Again"),
            ),
            TextButton(
                onPressed: () => print("Forgot Pressed"),
                child: const Text(
                  "I Can't Remember!",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
      title: const Text(
        "Oops..Let's Try Again!",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );
}


                  /*onPressed: () async {
                                      var _currentUser = await wooController.loginCustomer(
                                          username: _email, password: _password);
                                      bool isLoggedIn =
                                          await wooController.isCustomerLoggedIn();
                                      try {
                                        // Check if user is logged in
                                        if (_currentUser is WooCustomer) {
                                          final token = wooController.authenticateViaJWT(
                                              username: _email, password: _password);
                                          print(_email +
                                              "testt logged in! " +
                                              wooController.fetchLoggedInUserId().toString());
                
                                          //Set Current User
                                          setUserPreferences(_currentUser);
                                          CurrentUser thisUser = CurrentUser();
                                          thisUser.setUser(_currentUser);
                
                                          //Push to homepage
                                          await Get.to(() => const HomePage(),
                                              arguments: {'currentUser': _currentUser});
                                        } else if (_currentUser.runtimeType != WooCustomer) {
                                          print("Login Error");
                                          showLoginAlert(context);
                                        }
                                      } on Exception catch (e) {
                                        //print(e);
                                      }
                                    },*/