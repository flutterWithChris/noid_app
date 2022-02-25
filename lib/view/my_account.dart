import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noid_app/View/billing_info.dart';
import 'package:noid_app/view/account_info.dart';
import 'package:noid_app/view/bottom_nav_bar.dart';
import 'package:noid_app/View/current_user.dart';
import 'package:noid_app/view/main_app_bar.dart';
import 'package:noid_app/view/menu_item.dart';
import 'package:noid_app/view/my_orders.dart';
import 'package:noid_app/view/shipping_info.dart';
import 'package:woocommerce/models/customer.dart';

class MyAccount extends StatelessWidget {
  MyAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WooCustomer? _currentUser = CurrentUser.instance;

    return Scaffold(
      appBar: const MainAppBar(),
      bottomNavigationBar: BottomNavBar(),
      body: ListView(
        children: [
          const SizedBox(
            // Profile Icon
            child: Icon(Icons.account_circle_outlined, size: 125),
            height: 175,
          ),
          SizedBox(
            //Name Plate
            child: Text(
              _currentUser!.firstName + " " + _currentUser.lastName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _currentUser.email,
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
                  onTap: () => Get.to(() => const AccountInfo()),
                ),
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
    );
  }
}
