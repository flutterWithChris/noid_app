import 'package:flutter/material.dart';
import 'package:noid_app/view/bottom_nav_bar.dart';
import 'package:noid_app/view/main_app_bar.dart';
import 'package:noid_app/view/menu_item.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      bottomNavigationBar: BottomNavBar(index: 2),
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
              'Sandra Leno',
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
                ),
                Divider(),
                MenuItem(
                    itemName: 'Manage Subscriptions',
                    leadingIcon: Icon(Icons.subscriptions_outlined)),
                Divider(),
                MenuItem(
                  itemName: 'Billing Info',
                  leadingIcon: Icon(Icons.toll),
                ),
                Divider(),
                MenuItem(
                    itemName: 'Shipping Addresses',
                    leadingIcon: Icon(Icons.home_outlined)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
