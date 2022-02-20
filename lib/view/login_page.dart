import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:noid_app/Controller/woo_controller.dart';
import 'package:noid_app/view/home_page.dart';
import 'package:noid_app/view/main_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wp_json_api/models/responses/wp_user_register_response.dart';
import 'package:wp_json_api/wp_json_api.dart';
import 'current_user.dart';

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
  late WPUserRegisterResponse wpUserRegisterResponse;
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
                    obscureText: true,
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
                          await Get.to(() => HomePage(),
                              arguments: {'currentUser': _currentUser});
                        } else if (_currentUser.runtimeType != WooCustomer) {
                          print("Login Error");
                          showLoginAlert(context);
                        }
                      } on Exception catch (e) {
                        //print(e);
                      }
                    },
                    child: Text('Log In')),
                SizedBox(
                  width: 15,
                ),
                OutlinedButton(
                    onPressed: () async {
                      WooCustomer newUser = WooCustomer(
                          username: _email, password: _password, email: _email);
                      final result = wooController.createCustomer(newUser);
                    },
                    child: Text('Sign Up')),
              ],
            ),
            //TODO: Forgot Button
            TextButton(
                onPressed: () {
                  print("Forgot Pressed");
                },
                child: Text('Forgot Username/Password'))
          ],
        ),
      ),
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
            Text(
              "Looks like somethings not quite right.",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () => Get.back(),
              child: Text("Try Again"),
            ),
            TextButton(
                onPressed: () => print("Forgot Pressed"),
                child: Text(
                  "I Can't Remember!",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
      title: Text(
        "Oops..Let's Try Again!",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );
}

setUserPreferences(WooCustomer thisUser) async {
  final prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = await wooController.isCustomerLoggedIn();

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
