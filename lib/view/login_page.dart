import 'package:flutter/material.dart';
import 'package:noid_app/Controller/woo_controller.dart';
import 'package:noid_app/view/main_app_bar.dart';
import 'package:woocommerce/woocommerce.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  WooCommerce _wooCommerce = wooController;
  @override
  Widget build(BuildContext context) {
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
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      label: Text('Username'),
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
                    decoration: InputDecoration(
                      label: Text('Password'),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onSubmitted: _wooCommerce.,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,.0
            ),
            //TODO: Submit Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.lightGreen),
                    onPressed: () => print('login'),
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
