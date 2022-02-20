import 'package:flutter/material.dart';
import 'package:noid_app/view/bottom_nav_bar.dart';
import 'package:noid_app/view/main_app_bar.dart';
import 'package:noid_app/view/my_orders.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woocommerce/models/customer.dart';
import 'globals.dart' as globals;

class BillingInfo extends StatefulWidget {
  BillingInfo({Key? key}) : super(key: key);

  @override
  State<BillingInfo> createState() => _BillingInfoState();
}

class _BillingInfoState extends State<BillingInfo> {
  WooCustomer? _currentUser = globals.currentUser;
  String? billingAddress1;
  String? billingAddress2;
  String? billingCity;
  String? billingState;
  String? billingZipcode;
  String? billingCompany;

  getBillingInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      billingAddress1 = prefs.getString('billingAddress1')!;
      billingAddress2 = prefs.getString('billingAddress2')!;
      billingCity = prefs.getString('billingCity')!;
      billingState = prefs.getString('billingState')!;
      billingZipcode = prefs.getString('billingZipcode')!;
      billingCompany = prefs.getString('billingCompany')!;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        Wrap(
                          runSpacing: 20,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  label: Text('Address Line 1')),
                              initialValue: billingAddress1,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  label: Text('Address Line 2')),
                              initialValue: billingAddress2,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  label: Text('City')),
                              initialValue: billingCity,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  label: Text('State')),
                              initialValue: billingState,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  label: Text('Zipcode')),
                              initialValue: billingZipcode,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  label: Text('Company')),
                              initialValue: billingCompany,
                            ),
                          ],
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
