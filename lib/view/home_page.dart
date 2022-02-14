import 'package:flutter/material.dart';
import 'package:noid_app/Model/current_user.dart';
import 'package:noid_app/Model/order.dart';
import 'package:noid_app/View/shop_page.dart';
import 'package:noid_app/routes/route.dart';
import 'package:noid_app/view/bottom_nav_bar.dart';
import 'package:noid_app/view/main.dart';
import 'package:noid_app/view/main_app_bar.dart';
import 'package:noid_app/view/order_card.dart';
import 'package:noid_app/view/order_info.dart';
import 'package:noid_app/view/profile_card.dart';
import 'package:woocommerce/models/customer.dart';
import 'hero_slider.dart';
import 'my_account.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Map<String, WooCustomer> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, WooCustomer>;
    WooCustomer? _currentUser = arguments["currentUser"];
    print(_currentUser!.firstName + " " + _currentUser.lastName);

    final orders = List.generate(
        5,
        (index) => Order(
            orderNumber: 12343,
            orderDate: '12/2/22',
            orderType: 'Online',
            orderStatus: 'Shipped',
            orderTotal: 93.45,
            shippingAddress: '74 Peacock Ave'));

    return Scaffold(
      appBar: MainAppBar(),
      body: ListView(
        children: [
          ProfileCard(currentUser: _currentUser),
          HeroSlider(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
