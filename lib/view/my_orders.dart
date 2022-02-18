import 'package:flutter/material.dart';
import 'package:noid_app/Controller/woo_controller.dart';
import 'package:noid_app/routes/route.dart';
import 'package:noid_app/view/bottom_nav_bar.dart';
import 'package:noid_app/view/main_app_bar.dart';
import 'package:noid_app/view/order_card.dart';
import 'package:noid_app/view/order_cards.dart';
import 'package:woocommerce/woocommerce.dart';
import 'globals.dart' as globals;

class MyOrders extends StatefulWidget {
  MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  WooCommerce _wooController = wooController;
  WooCustomer user = globals.currentUser;

  List<WooOrder> allOrders = [];

  getOrders() async {
    print(user.id);
    allOrders = await _wooController.getOrders(customer: user.id);
  }

  @override
  Widget build(BuildContext context) {
    getOrders();
    return Scaffold(
      appBar: const MainAppBar(),
      bottomNavigationBar: BottomNavBar(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final order = allOrders[index];
          return OrderCard(order: order);
        },
      ),
    );
  }
}
