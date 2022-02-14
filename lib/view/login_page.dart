import 'package:flutter/material.dart';
import 'package:noid_app/Controller/woo_controller.dart';
import 'package:noid_app/Model/current_user.dart';
import 'package:noid_app/routes/route.dart';
import 'package:noid_app/view/home_page.dart';
import 'package:noid_app/view/main_app_bar.dart';
import 'package:wp_json_api/models/responses/wp_user_login_response.dart';
import 'package:wp_json_api/wp_json_api.dart';

import 'dart:convert' show json, base64, ascii;

import 'package:woocommerce/woocommerce.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  WooCommerce _wooCommerce = wooController;
  String _email = '';
  String _password = '';
  @override
  Widget build(BuildContext context) {
    WooCustomer currentUser;

    return Scaffold(
      appBar: MainAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //TODO: Icon
            SizedBox(
              child: Icon(Icons.account_circle_outlined, size: 125),
              height: 175,
            ),
            //TODO: Login Fields
            SizedBox(
              width: 280,
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    onChanged: (String value) {
                      _email = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      label: Text('Email'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 280,
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    onChanged: (String value) {
                      _password = value;
                    },
                    decoration: InputDecoration(
                      label: Text('Password'),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //TODO: Submit Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.lightGreen),
                    onPressed: () async {
                      try {
                        WooCustomer _currentUser =
                            await wooController.loginCustomer(
                                username: _email, password: _password);
                        bool isLoggedIn =
                            await wooController.isCustomerLoggedIn();

                        // Check if user is logged in
                        if (isLoggedIn = true) {
                          final token = wooController.authenticateViaJWT(
                              username: _email, password: _password);
                          print(_email +
                              " logged in! " +
                              wooController.fetchLoggedInUserId().toString());

                          //Set Current User
                          currentUser = _currentUser;

                          //Push to homepage
                          await Navigator.pushNamed(
                              context, RouteManager.homePage,
                              arguments: {'currentUser' : _currentUser});
                        }
                      } on Exception catch (e) {
                        AlertDialog(
                          title: Text('Invalid Username/Password!'),
                          content: Text('Please try again!'),
                        );
                        print(e);
                      }
                    },
                    child: Text('Log In')),
                SizedBox(
                  width: 15,
                ),
                OutlinedButton(
                    onPressed: () => print('sign up'), child: Text('Sign Up')),
              ],
            ),
            //TODO: Forgot Button
            TextButton(
                onPressed: () => print('forgot pressed'),
                child: Text('Forgot Username/Password'))
          ],
        ),
      ),
    );
  }
}
