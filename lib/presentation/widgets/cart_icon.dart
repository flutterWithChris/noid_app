import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:get/get.dart';
import 'package:noid_app/data/Model/woo_controller.dart';
import 'package:woocommerce/models/cart_item.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int count = 0;
    GetCartCount(count);
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        FloatingActionButton(
          backgroundColor: Colors.lightGreen,
          foregroundColor: Colors.white,
          onPressed: (() {
            //Get.to(() => CartPage());
            print("Cart Pressed");
          }),
          child: Icon(Icons.shopping_cart),
        ),
        Badge(
          badgeContent: Text(
            count.toString(),
            style: TextStyle(color: Colors.white),
          ),
          badgeColor: Colors.red,
        ),
      ],
    );
  }
}

GetCartCount(int count) async {
  List<WooCartItem> cartItems = await wooController.getMyCartItems();
  var cartCount = cartItems.length;
  count = cartCount;
}
