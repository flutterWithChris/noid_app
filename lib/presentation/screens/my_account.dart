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
    setState(() {
      widget.firstName = _firstName;
    });
  }

  Future getLastName() async {
    final _lastName = await UserStorage.getLastName() ?? '';
    setState(() {
      widget.lastName = _lastName;
    });
  }

  Future getEmail() async {
    final _email = await UserStorage.getEmail() ?? '';
    setState(() {
      widget.email = _email;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserRepo userRepo = RepositoryProvider.of<UserRepo>(context);

    // User _currentUser = userRepo.getCurrentUser;
    getEmail();
    getFirstName();
    getLastName();
    final String initials =
        widget.firstName.characters.characterAt(0).toString() +
            widget.lastName.characters.characterAt(0).toString();
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
                  future: getLastName(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData == true) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return CircleAvatar(
                        radius: 40.0,
                        backgroundColor: Colors.white,
                        child: Text(
                          initials,
                          textScaleFactor: 2.0,
                        ),
                      );
                    }
                  }),
            ),
            SizedBox(
              //Name Plate
              child: Text(
                widget.firstName + " " + widget.lastName,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.email,
                textAlign: TextAlign.center,
              ),
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
