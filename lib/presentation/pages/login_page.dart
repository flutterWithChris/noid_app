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
      appBar: MainAppBar(),
      body: BlocProvider(
        create: (context) => LoginBloc(
          userRepo: context.read<UserRepo>(),
        ),
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
    return Form(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            _usernameField(),
            _passwordField(),
            _loginButton(),
          ],
        ),
      ),
    );

    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //TODO: Icon
          const SizedBox(
            child: Icon(Icons.account_circle_outlined, size: 125),
            height: 175,
          ),
          //TODO: Login Fields
          SizedBox(
            width: 280,
            child: Column(
              children: const [
                SizedBox(
                  height: 15,
                ),
                _usernameField(),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 280,
            child: Column(
              children: const [
                SizedBox(
                  height: 15,
                ),
                _passwordField(),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          //TODO: Submit Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _loginButton(),
              const SizedBox(
                width: 15,
              ),
              OutlinedButton(
                  onPressed: () async {}, child: const Text('Sign Up')),
            ],
          ),

          //TODO: Forgot Button
          TextButton(
              onPressed: () {
                print("Forgot Pressed");
              },
              child: const Text('Forgot Username/Password'))
        ],
      ),
    );
  }
}

class _loginButton extends StatelessWidget {
  const _loginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(userRepo: context.read<UserRepo>()),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.lightGreen),
            onPressed: () {
              print("Login Button Pressed");
              print("Login Attempt Started");
              //context.read<LoginBloc>().add(LoginSubmit());
              context.read<LoginBloc>().add(LoginAttempt());
              context.read<LoginBloc>().emit(LoginSuccess());
            },
            child: const Text('Log In'),
          );
        },
      ),
    );
  }
}

class _passwordField extends StatelessWidget {
  const _passwordField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: true,
          onChanged: (String value) {
            context
                .read<LoginBloc>()
                .add(LoginPasswordChanged(password: value));
          },
          decoration: const InputDecoration(
            label: Text('Password'),
            filled: true,
            fillColor: Colors.white,
          ),
        );
      },
    );
  }
}

class _usernameField extends StatelessWidget {
  const _usernameField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          onChanged: (String value) {
            context
                .read<LoginBloc>()
                .add(LoginUsernameChanged(username: value));
          },
          decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white,
            label: Text('Email'),
          ),
          validator: (value) => null,
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

setUserPreferences(WooCustomer thisUser) async {
  final prefs = await SharedPreferences.getInstance();
  var _wooController = WooRepo().wooController;
  bool isLoggedIn = await _wooController.isCustomerLoggedIn();

  await prefs.setInt('userId', thisUser.id);
  await prefs.setString('firstName', thisUser.firstName);
  await prefs.setString('lastName', thisUser.lastName);
  await prefs.setString('email', thisUser.email);
  await prefs.setBool('isLoggedIn', isLoggedIn);
  await prefs.setString('shippingAddress1', thisUser.shipping.address1);
  await prefs.setString('shippingAddress2', thisUser.shipping.address2);
  await prefs.setString('shippingCity', thisUser.shipping.city);
  await prefs.setString('shippingState', thisUser.shipping.state);
  await prefs.setString('shippingZipcode', thisUser.shipping.postcode);
  await prefs.setString('shippingCountry', thisUser.shipping.country);
  await prefs.setString('shippingCompany', thisUser.shipping.company);
  await prefs.setString('billingAddress1', thisUser.billing.address1);
  await prefs.setString('billingAddress2', thisUser.billing.address2);
  await prefs.setString('billingCity', thisUser.billing.city);
  await prefs.setString('billingState', thisUser.billing.state);
  await prefs.setString('billingZipcode', thisUser.billing.postcode);
  await prefs.setString('billingCountry', thisUser.billing.country);
  await prefs.setString('billingCompany', thisUser.billing.company);
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