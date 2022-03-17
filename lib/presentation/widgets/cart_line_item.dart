import 'package:flutter/material.dart';
import 'package:woocommerce/models/cart_item.dart';

class CartLineItem extends StatelessWidget {
  final WooCartItem product;

  CartLineItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.offline_bolt),
      title: Text(
        product.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle:
          Text("ID: " + product.id.toString() + " | Price: \$" + product.price),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Qty: x " + product.quantity.toString(),
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text("Subtotal: \$ " + product.linePrice),
        ],
      ),
    );
  }
}
