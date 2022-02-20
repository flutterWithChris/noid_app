import 'package:flutter/material.dart';
import 'package:noid_app/view/bottom_nav_bar.dart';
import 'package:noid_app/view/current_user.dart';
import 'package:noid_app/view/main_app_bar.dart';
import 'package:woocommerce/models/customer.dart';

import 'my_orders.dart';

class AccountInfo extends StatelessWidget {
  AccountInfo({Key? key}) : super(key: key);

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController companyController = TextEditingController();

  getBillingInfo() async {
    WooCustomer? _currentUser = CurrentUser.instance;
    //print(user!.firstName + "is the damn user");

    firstNameController.text = _currentUser!.firstName;
    lastNameController.text = _currentUser!.lastName;
    emailController.text = _currentUser!.email;
  }

  @override
  Widget build(BuildContext context) {
    void dispose() {
      firstNameController.dispose();
      lastNameController.dispose();
      emailController.dispose();
    }

    return Scaffold(
      appBar: MainAppBar(),
      bottomNavigationBar: BottomNavBar(),
      body: FutureBuilder(
          future: getBillingInfo(),
          builder: (context, snapshot) {
            if (snapshot == null) {
              return isLoading();
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Center(
                          heightFactor: 2.0,
                          child: Text(
                            "Account Info",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: .9,
                          child: Wrap(
                            runSpacing: 20,
                            children: [
                              // HEADING
                              TextFormField(
                                controller: firstNameController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white70,
                                    label: Text('First Name')),
                              ),
                              TextFormField(
                                controller: lastNameController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white70,
                                    label: Text('Last Name')),
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white70,
                                    label: Text('Email Address')),
                                controller: emailController,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          }),
    );
    ;
  }
}
