import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noid_app/data/Model/current_user.dart';
import 'package:noid_app/data/Model/order.dart';
import 'package:noid_app/presentation/widgets/bottom_nav_bar.dart';
import 'package:noid_app/presentation/widgets/hero_slider.dart';
import 'package:noid_app/presentation/widgets/main_app_bar.dart';
import 'package:noid_app/presentation/widgets/profile_card.dart';
import 'package:woocommerce/models/customer.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static late Map<String, WooCustomer> arguments;
  static WooCustomer? _currentUser = CurrentUser.instance;

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

    print(_currentUser!.firstName + " " + _currentUser!.lastName + "Set!!");
    print(_currentUser!.firstName + " set as user");

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
      appBar: const MainAppBar(),
      body: ListView(
        children: [
          ProfileCard(currentUser: _currentUser),
          const HeroSlider(),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
