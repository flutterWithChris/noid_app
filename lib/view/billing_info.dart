import 'package:flutter/material.dart';
import 'package:noid_app/view/bottom_nav_bar.dart';
import 'package:noid_app/view/main_app_bar.dart';
import 'package:woocommerce/models/customer.dart';
import 'globals.dart' as globals;

class BillingInfo extends StatelessWidget {
  const BillingInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WooCustomer user = globals.currentUser;
    return Scaffold(
      appBar: MainAppBar(),
      bottomNavigationBar: BottomNavBar(),
      body: Column(children: [
        Center(
          heightFactor: 1.618,
          child: Text(
            'Billing Info',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FractionallySizedBox(
            widthFactor: .9,
            child: Column(
              children: [
                TextFormField(
                  initialValue: user.firstName,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white70,
                    label: Text("First Name"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
