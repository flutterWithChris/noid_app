import 'package:flutter/material.dart';
import 'package:noid_app/view/bottom_nav_bar.dart';
import 'package:noid_app/view/main_app_bar.dart';
import 'package:noid_app/view/my_orders.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woocommerce/models/customer.dart';
import 'package:noid_app/view/current_user.dart';

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

  getBillingInfo() async {
    WooCustomer? _currentUser = CurrentUser.instance;
    //print(user!.firstName + "is the damn user");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() async {
      address1Controller.text = _currentUser!.billing.address1;
      address2Controller.text = _currentUser!.billing.address2;
      cityController.text = _currentUser!.billing.city;
      stateController.text = _currentUser!.billing.state;
      zipController.text = _currentUser!.billing.postcode;
      companyController.text = _currentUser!.billing.company;
    });
  }

  updateBillingInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    address1Controller.addListener(() {
      prefs.setString('billingAddress1', address1Controller.text);
      prefs.setString('billingAddress2', address2Controller.text);
      prefs.setString('billingState', stateController.text);
      prefs.setString('billingCity', cityController.text);
      prefs.setString('billingZipcode', zipController.text);
      prefs.setString('billingCompany', companyController.text);
    });
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

    // print(_currentUser!.firstName + " is still set as user");
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
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white70,
                                    label: Text('Address Line 1')),
                              ),
                              TextFormField(
                                controller: address2Controller,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white70,
                                    label: Text('Address Line 2')),
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white70,
                                    label: Text('City')),
                                controller: cityController,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white70,
                                    label: Text('State')),
                                controller: stateController,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white70,
                                    label: Text('Zipcode')),
                                controller: zipController,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
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

Future<SharedPreferences> _getPreferences() async {
  var getPrefs = await SharedPreferences.getInstance();
  SharedPreferences prefs = getPrefs;
  return prefs;
}
