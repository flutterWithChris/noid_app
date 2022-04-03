import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:noid_app/data/Model/cart_model.dart';
import 'package:noid_app/data/Model/woo_controller.dart';
import 'package:noid_app/data/repository/cart_repo.dart';
import 'package:noid_app/logic/bloc/cart/cart_bloc.dart';
import 'package:noid_app/presentation/pages/my_cart.dart';
import 'package:noid_app/presentation/pages/shop_page.dart';
import 'package:noid_app/presentation/widgets/cart_line_item.dart';
import 'package:noid_app/presentation/widgets/line_item.dart';
import 'package:noid_app/presentation/widgets/order_line_item.dart';
import 'package:woocommerce/models/cart.dart';
import 'package:woocommerce/models/cart_item.dart';
import 'package:woocommerce/models/order.dart';
import 'package:woocommerce/models/products.dart';

class CartIcon extends StatelessWidget {
  CartIcon({Key? key}) : super(key: key);
  Map<int, int> cartItems = {};

  @override
  Widget build(BuildContext context) {
    CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        FloatingActionButton(
          heroTag: 'cart-widget',
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
                      child: Card(
                        child: ListView(
                          shrinkWrap: true,
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
                            Wrap(
                              children: [
                                Text('Total: '),
                                Text('Items: '),
                              ],
                            ),
                            Wrap(
                              alignment: WrapAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.lightGreen)),
                                  onPressed: () {
                                    print('pressed');
                                  },
                                  child: Text('Checkout'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );

            //Get.to(() => CartPage());4
            print("Cart Pressed");
          }),
          child: const Icon(Icons.shopping_cart),
        ),
        Badge(
          badgeContent: StreamBuilder<int>(
              stream: cartBloc.itemCount,
              initialData: 0,
              builder: (context, AsyncSnapshot<int> snapshot) {
                int itemCount = snapshot.data!;
                return Text(
                  itemCount.toString(),
                  style: const TextStyle(color: Colors.white),
                );
              }),
          badgeColor: Colors.red,
        )
      ],
    );
  }
}
