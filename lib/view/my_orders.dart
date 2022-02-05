import 'package:flutter/material.dart';
import 'package:noid_app/routes/route.dart';
import 'package:noid_app/view/bottom_nav_bar.dart';
import 'package:noid_app/view/main_app_bar.dart';
import 'package:noid_app/view/order_card.dart';
import 'package:noid_app/view/order_cards.dart';

class MyOrders extends StatelessWidget {
  MyOrders({Key? key}) : super(key: key);
  int currentOrderNum = 0;

  @override
  Widget build(BuildContext context) {
    final currentOrder = OrderCards.of(context);

    return Scaffold(
      appBar: const MainAppBar(),
      bottomNavigationBar: BottomNavBar(),
      body: ListView(
        children: [
          SizedBox(
              height: 75,
              child: Center(
                child: Text('My Orders',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              )),
        
          Divider(),
        ],
        
      ),
    );
  }
}
