import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:noid_app/presentation/screens/shipping_info.dart';
import 'package:noid_app/data/Model/user.dart';
import 'package:noid_app/data/repository/user_repo.dart';
import 'package:noid_app/data/repository/user_storage.dart';
import 'package:noid_app/presentation/screens/account_info.dart';
import 'package:noid_app/presentation/screens/billing_info.dart';
import 'package:noid_app/presentation/screens/my_orders.dart';
import 'package:noid_app/presentation/widgets/bottom_nav_bar.dart';
import 'package:noid_app/presentation/widgets/main_app_bar.dart';
import 'package:noid_app/presentation/widgets/menu_item.dart';

class MyAccount extends StatefulWidget {
  String firstName = '';
  String lastName = '';
  String email = '';
  MyAccount({
    Key? key,
  }) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  Future getFirstName() async {
    final _firstName = await UserStorage.getFirstName() ?? '';
    return _firstName;
  }

  Future getLastName() async {
    final _lastName = await UserStorage.getLastName() ?? '';
    return _lastName;
  }

  Future<String> getFullName() async {
    final _firstName = await getFirstName();
    final _lastName = await getLastName();
    final _fullName = _firstName + ' ' + _lastName;
    return _fullName;
  }

  Future getEmail() async {
    final _email = await UserStorage.getEmail() ?? '';
    return _email;
  }

  Future<String> getInitials() async {
    String firstname = await getFirstName();
    String lastname = await getLastName();
    final String initials =
        await firstname.characters.characterAt(0).toString() +
            lastname.characters.characterAt(0).toString();
    return initials;
  }

  @override
  Widget build(BuildContext context) {
    UserRepo userRepo = RepositoryProvider.of<UserRepo>(context);

    // User _currentUser = userRepo.getCurrentUser;

    return Scaffold(
      appBar: const MainAppBar(),
      bottomNavigationBar: const BottomNavBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: FutureBuilder(
                  future: getInitials(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return CircleAvatar(
                        radius: 40.0,
                        backgroundColor: Colors.white,
                        child: Text(
                          snapshot.data as String,
                          textScaleFactor: 2.0,
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            SizedBox(
              //Name Plate
              child: FutureBuilder(
                  future: getFullName(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Text(
                        snapshot.data as String,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                  future: getEmail(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      var fullname = snapshot.data as String;
                      return Text(
                        fullname,
                        textAlign: TextAlign.center,
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
            const SizedBox(
              // White Space
              height: 25,
            ),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: Column(
                children: [
                  MenuItem(
                      itemName: 'Account Info',
                      leadingIcon: const Icon(Icons.person),
                      onTap: () {
                        Get.to(() => const AccountInfo());
                      }),
                  const Divider(),
                  MenuItem(
                    itemName: 'My Orders',
                    leadingIcon: const Icon(Icons.checklist),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyOrders(),
                        )),
                  ),
                  const Divider(),
                  MenuItem(
                      itemName: 'Billing',
                      leadingIcon: const Icon(Icons.toll),
                      onTap: () => Get.to(() => const BillingInfo())),
                  const Divider(),
                  MenuItem(
                    itemName: 'Shipping',
                    leadingIcon: const Icon(Icons.home_outlined),
                    onTap: () => Get.to(() => const ShippingInfo()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
