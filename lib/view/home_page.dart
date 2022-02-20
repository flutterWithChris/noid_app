import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noid_app/Model/current_user.dart';
import 'package:noid_app/Model/order.dart';
import 'package:noid_app/View/shop_page.dart';
import 'package:noid_app/routes/route.dart';
import 'package:noid_app/view/bottom_nav_bar.dart';
import 'package:noid_app/main.dart';
import 'package:noid_app/view/main_app_bar.dart';
import 'package:noid_app/view/order_card.dart';
import 'package:noid_app/view/order_info.dart';
import 'package:noid_app/view/profile_card.dart';
import 'package:woocommerce/models/customer.dart';
import 'hero_slider.dart';
import 'my_account.dart';
import 'globals.dart' as globals;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static late Map<String, WooCustomer> arguments;
  static WooCustomer? _currentUser;

  @override
  Widget build(BuildContext context) {
    if (Get.previousRoute == '/') {
      print('Log In Route');
      arguments = ModalRoute.of(context)!.settings.arguments
          as Map<String, WooCustomer>;
      _currentUser = arguments["currentUser"];
    } else {
      print('Other Route');
    }

    print(_currentUser!.firstName + " " + _currentUser!.lastName);
    print(globals.currentUser!.firstName + " set as user");

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
