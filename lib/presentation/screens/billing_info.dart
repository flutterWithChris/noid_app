import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noid_app/data/Model/current_user.dart';
import 'package:noid_app/data/Model/user.dart';
import 'package:noid_app/data/repository/user_repo.dart';
import 'package:noid_app/data/repository/user_storage.dart';
import 'package:noid_app/presentation/pages/shop_page.dart';
import 'package:noid_app/presentation/widgets/bottom_nav_bar.dart';
import 'package:noid_app/presentation/widgets/main_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woocommerce/models/customer.dart';

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
    var id = await UserStorage.getUserId();
    var billing = await UserRepo().getBillingInfo(int.parse(id!));
    address1Controller.text = billing.address1;
    address2Controller.text = billing.address2;
    cityController.text = billing.city;
    stateController.text = billing.state;
    zipController.text = billing.postcode;
    companyController.text = billing.company;
  }

  @override
  Widget build(BuildContext context) {
    // User _currentUser = UserRepo().getCurrentUser;

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
                                    suffixIcon: const Icon(Icons.lock),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(45.0),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    label: Text('Address Line 1')),
                              ),
                              TextFormField(
                                controller: address2Controller,
                                decoration: InputDecoration(
                                    suffixIcon: const Icon(Icons.lock),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(45.0),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    label: Text('Address Line 2')),
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    suffixIcon: const Icon(Icons.lock),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(45.0),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    label: Text('City')),
                                controller: cityController,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    suffixIcon: const Icon(Icons.lock),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(45.0),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    label: Text('State')),
                                controller: stateController,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    suffixIcon: const Icon(Icons.lock),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(45.0),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    label: Text('Zipcode')),
                                controller: zipController,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    suffixIcon: const Icon(Icons.lock),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(45.0),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    label: Text('Company')),
                                controller: companyController,
                              ),
                              Center(
                                child: FractionallySizedBox(
                                  alignment: Alignment.center,
                                  widthFactor: 0.9,
                                  child: OutlinedButton(
                                      onPressed: () => print("pressed"),
                                      child: Wrap(
                                        spacing: 12,
                                        children: const [
                                          Icon(
                                            Icons.edit,
                                            size: 15,
                                          ),
                                          Text("Edit"),
                                        ],
                                      )),
                                ),
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
