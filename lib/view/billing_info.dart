import 'package:flutter/material.dart';
import 'package:noid_app/view/bottom_nav_bar.dart';
import 'package:noid_app/view/main_app_bar.dart';
import 'package:noid_app/view/my_orders.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woocommerce/models/customer.dart';
import 'package:noid_app/View/current_user.dart';

class BillingInfo extends StatefulWidget {
  const BillingInfo({Key? key}) : super(key: key);

  @override
  State<BillingInfo> createState() => _BillingInfoState();
}

class _BillingInfoState extends State<BillingInfo> {
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController companyController = TextEditingController();

  getBillingInfo() {
    WooCustomer? _currentUser = CurrentUser.instance;
    if (_currentUser != null) {
      address1Controller.text = _currentUser.billing.address1;
      address2Controller.text = _currentUser.billing.address2;
      cityController.text = _currentUser.billing.city;
      stateController.text = _currentUser.billing.state;
      zipController.text = _currentUser.billing.postcode;
      companyController.text = _currentUser.billing.company;
    } else {
      print("Billing Info Error!");
    }
  }

  @override
  Widget build(BuildContext context) {
    getBillingInfo();

    @override
    void dispose() {
      address1Controller.dispose();
      address2Controller.dispose();
      cityController.dispose();
      stateController.dispose();
      zipController.dispose();
      companyController.dispose();
    }

    return Scaffold(
      appBar: const MainAppBar(),
      bottomNavigationBar: const BottomNavBar(),
      body: FutureBuilder(
          future: getBillingInfo(),
          builder: (context, snapshot) {
            if (snapshot == null) {
              return const IsLoading();
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        const Center(
                          heightFactor: 2.0,
                          child: Text(
                            "Billing Info",
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
                                controller: address1Controller,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white70,
                                    label: Text('Address Line 1')),
                              ),
                              TextFormField(
                                controller: address2Controller,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white70,
                                    label: Text('Address Line 2')),
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white70,
                                    label: Text('City')),
                                controller: cityController,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white70,
                                    label: Text('State')),
                                controller: stateController,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white70,
                                    label: Text('Zipcode')),
                                controller: zipController,
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white70,
                                    label: Text('Company')),
                                controller: companyController,
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
  }
}
