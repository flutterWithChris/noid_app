import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:get/get.dart';
import 'package:noid_app/data/Model/woo_controller.dart';
import 'package:noid_app/data/repository/cart_repo.dart';
import 'package:noid_app/presentation/pages/my_cart.dart';
import 'package:noid_app/presentation/pages/shop_page.dart';
import 'package:noid_app/presentation/widgets/cart_line_item.dart';
import 'package:noid_app/presentation/widgets/line_item.dart';
import 'package:noid_app/presentation/widgets/order_line_item.dart';
import 'package:woocommerce/models/cart_item.dart';
import 'package:woocommerce/models/order.dart';

class CartIcon extends StatelessWidget {
  CartIcon({Key? key}) : super(key: key);
  final List<WooCartItem> cartItems = [];

  void getCartItems() async {
    final _item;
    final List<WooCartItem> _cartItems = await CartRepo().getAllCartItems();
    for (var i = 0; i < _cartItems.length; i++) {
      cartItems.add(_cartItems.elementAt(i));
    }
    print(cartItems.length.toString() + " Current Cart Items");
  }

  @override
  Widget build(BuildContext context) {
    int count = 0;
    GetCartCount(count);
    getCartItems();

    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        FloatingActionButton(
          backgroundColor: Colors.lightGreen,
          foregroundColor: Colors.white,
          onPressed: (() {
            //Get.to(() => MyCart());
            showDialog(
              context: context,
              builder: (context) {
                return SizedBox(
                  height: 100,
                  child: Dialog(
                    child: Container(
                      height: 400,
                      child: Card(
                        child: Column(
                          children: [
                            const ListTile(
                              title: Text(
                                'My Cart',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: cartItems.length,
                                itemBuilder: (context, index) {
                                  return CartLineItem(
                                      product: cartItems.elementAt(index));
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );

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
  List<WooCartItem> cartItems = await WooRepo().wooController.getMyCartItems();
  var cartCount = cartItems.length;
  count = cartCount;
}
