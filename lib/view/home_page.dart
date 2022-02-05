import 'package:flutter/material.dart';
import 'package:noid_app/Model/order.dart';
import 'package:noid_app/View/shop_page.dart';
import 'package:noid_app/routes/route.dart';
import 'package:noid_app/view/bottom_nav_bar.dart';
import 'package:noid_app/view/main.dart';
import 'package:noid_app/view/main_app_bar.dart';
import 'package:noid_app/view/order_card.dart';
import 'package:noid_app/view/order_info.dart';
import 'hero_slider.dart';
import 'my_account.dart';
import 'profile_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
          const ProfileCard(),
          OrderCard(thisOrder: orders[0]),
          HeroSlider(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
