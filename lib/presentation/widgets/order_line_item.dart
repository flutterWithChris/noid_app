import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:noid_app/data/Model/woo_controller.dart';
import 'package:woocommerce/models/order.dart';
import 'package:woocommerce/models/products.dart';
import 'package:woocommerce/woocommerce.dart';

class OrderLineItem extends StatelessWidget {
  LineItems product;
  int quantity;
  String price;
  String subtotal;

  OrderLineItem(
      {Key? key,
      required this.product,
      required this.quantity,
      required this.price,
      required this.subtotal})
      : super(key: key);

  Future<WooProduct> getProduct(int id) async {
    WooProduct wooProduct =
        await WooRepo().wooController.getProductById(id: id);
    return wooProduct;
  }

  @override
  Widget build(BuildContext context) {
    LineItems _product = product;
    Future<WooProduct> wooProduct =
        WooRepo().wooController.getProductById(id: _product.productId);

    return ListTile(
      leading: Icon(Icons.offline_bolt),
      title: Text(
        _product.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
          "ID: " + _product.id.toString() + " | Price: \$" + _product.price),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Qty: x " + quantity.toString(),
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text("Subtotal: " + '\$' + subtotal.toString())
        ],
      ),
    );
  }
}
