import 'package:flutter/material.dart';
import 'package:noid_app/presentation/widgets/bottom_nav_bar.dart';
import 'package:noid_app/presentation/widgets/line_item.dart';
import 'package:noid_app/presentation/widgets/main_app_bar.dart';
import 'package:woocommerce/models/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WooCart cart = WooCart();
    return Scaffold(
        appBar: MainAppBar(),
        bottomNavigationBar: BottomNavBar(),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "My Cart",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            SizedBox(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cart.itemCount,
                itemBuilder: (BuildContext context, int index) {
                  WooCartItems _currentItem = cart.items.elementAt(index);
                  return LineItem(
                    product: _currentItem,
                  );
                },
              ),
            )
          ],
        ));
  }
}
