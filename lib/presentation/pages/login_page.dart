import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:noid_app/data/repository/user_repo.dart';
import 'package:noid_app/logic/bloc/login_bloc.dart';
import 'package:noid_app/presentation/pages/home_page.dart';
import 'package:noid_app/presentation/widgets/login_app_bar.dart';
import 'package:noid_app/presentation/widgets/main_app_bar.dart';

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
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: BlocConsumer<LoginBloc, LoginState>(
          // * Listener for Success State -> Homepage
          listener: (context, state) {
            if (state is LoginSuccess) {
              Get.to(() => RepositoryProvider(
                    create: (context) => UserRepo(),
                    child: const HomePage(),
                  ));
            }
          },
          // * Builder based on LoginState
          builder: (context, state) {
            if (state is LoginInitial) {
              return _loginForm();
            }
            if (state is LoginLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is LoginFail) {
              return ErrorDialog(
                  loginBloc: BlocProvider.of<LoginBloc>(context));
            }
            return _loginForm();
          },
        ),
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
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Hero(
                tag: 'logo',
                child: Image.network(
                  'https://noidbotanicals.com/wp-content/uploads/2020/08/Asset-2.png',
                  height: 65,
                ),
              ),
            ),
            // ? Add Noid Logo to center?
            _usernameField(loginBloc: loginBloc),
            _passwordField(loginBloc: loginBloc),
            Wrap(
              spacing: 25,
              children: [
                _loginButton(loginBloc: loginBloc),
                _logoutButton(loginBloc: loginBloc),
              ],
            ),
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
          onPressed:
              snapshot.hasData ? () => loginBloc.add(LoginSubmit()) : null,
          child: const Text('Log In'),
        );
      },
    );
  }
}

class _logoutButton extends StatelessWidget {
  LoginBloc loginBloc;

  _logoutButton({
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
          style: ElevatedButton.styleFrom(primary: Colors.lightBlue),
          onPressed: () => loginBloc.add(LogOut()),
          child: const Text('Log Out'),
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(45.0),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
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
            label: const Text('Email Address'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(45.0),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
          ),
        );
      },
    );
  }
}

class ErrorDialog extends StatelessWidget {
  LoginBloc loginBloc;
  ErrorDialog({Key? key, required this.loginBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
              onPressed: () => loginBloc.add(LoginRetry()),
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
    );
  }
}
