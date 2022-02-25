import 'package:flutter/material.dart';
import 'package:noid_app/view/bottom_nav_bar.dart';
import 'package:noid_app/view/main_app_bar.dart';
import 'package:noid_app/view/my_orders.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:noid_app/View/current_user.dart';
import 'package:woocommerce/models/customer.dart';

class ShippingInfo extends StatefulWidget {
  const ShippingInfo({Key? key}) : super(key: key);

  @override
  State<ShippingInfo> createState() => _ShippingInfoState();
}

class _ShippingInfoState extends State<ShippingInfo> {
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController companyController = TextEditingController();

  getShippingInfo() {
    WooCustomer? _currentUser = CurrentUser.instance;
    //print(user!.firstName + "is the damn user");
    address1Controller.text = _currentUser!.shipping.address1;
    address2Controller.text = _currentUser.shipping.address2;
    cityController.text = _currentUser.shipping.city;
    stateController.text = _currentUser.shipping.state;
    zipController.text = _currentUser.shipping.postcode;
    companyController.text = _currentUser.shipping.company;
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
    getShippingInfo();
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
      appBar: const MainAppBar(),
      bottomNavigationBar: const BottomNavBar(),
      body: FutureBuilder(
          future: getShippingInfo(),
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
                            "Shipping Info",
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

Future<SharedPreferences> _getPreferences() async {
  var getPrefs = await SharedPreferences.getInstance();
  SharedPreferences prefs = getPrefs;
  return prefs;
}
