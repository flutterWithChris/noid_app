import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noid_app/Model/current_user.dart';
import 'package:noid_app/View/billing_info.dart';
import 'package:noid_app/View/my_subscriptions.dart';
import 'package:noid_app/View/shipping_addresses.dart';
import 'package:noid_app/routes/route.dart';
import 'package:noid_app/view/bottom_nav_bar.dart';
import 'package:noid_app/view/home_page.dart';
import 'package:noid_app/view/main_app_bar.dart';
import 'package:noid_app/view/menu_item.dart';
import 'package:noid_app/view/my_orders.dart';
import 'package:woocommerce/models/customer.dart';
import 'globals.dart' as globals;

class MyAccount extends StatelessWidget {
  MyAccount({Key? key}) : super(key: key);
  WooCustomer _currentUser = globals.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      bottomNavigationBar: BottomNavBar(),
      body: ListView(
        children: [
          SizedBox(
            // Profile Icon
            child: Icon(Icons.account_circle_outlined, size: 125),
            height: 175,
          ),
          SizedBox(
            //Name Plate
            child: Text(
              _currentUser.firstName + " " + _currentUser.lastName,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            // White Space
            height: 25,
          ),
          FractionallySizedBox(
            widthFactor: 0.8,
            child: Column(
              children: [
                MenuItem(
                  itemName: 'My Orders',
                  leadingIcon: Icon(Icons.checklist),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyOrders(),
                      )),
                ),
                Divider(),
                MenuItem(
                    itemName: 'Manage Subscriptions',
                    leadingIcon: Icon(Icons.subscriptions_outlined),
                    onTap: () => Get.to(MySubscriptions())),
                Divider(),
                MenuItem(
                    itemName: 'Billing Info',
                    leadingIcon: Icon(Icons.toll),
                    onTap: () => Get.to(BillingInfo())),
                Divider(),
                MenuItem(
                  itemName: 'Shipping Addresses',
                  leadingIcon: Icon(Icons.home_outlined),
                  onTap: () => Get.to(() => ShippingAddresses()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
