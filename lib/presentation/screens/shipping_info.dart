import 'package:flutter/material.dart';
import 'package:noid_app/data/Model/current_user.dart';
import 'package:noid_app/data/repository/user_repo.dart';
import 'package:noid_app/data/repository/user_storage.dart';
import 'package:noid_app/presentation/screens/my_orders.dart';
import 'package:noid_app/presentation/widgets/bottom_nav_bar.dart';
import 'package:noid_app/presentation/widgets/main_app_bar.dart';

import 'package:shared_preferences/shared_preferences.dart';

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

  getShippingInfo() async {
    var id = await UserStorage.getUserId();
    var shipping = await UserRepo().getShippingInfo(int.parse(id!));
    address1Controller.text = shipping.address1;
    address2Controller.text = shipping.address2;
    cityController.text = shipping.city;
    stateController.text = shipping.state;
    zipController.text = shipping.postcode;
    companyController.text = shipping.company;
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

    // print(.firstName + " is still set as user");
    return Scaffold(
      appBar: const MainAppBar(),
      bottomNavigationBar: const BottomNavBar(),
      body: FutureBuilder(
          future: getShippingInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
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
