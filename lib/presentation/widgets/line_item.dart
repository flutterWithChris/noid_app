import 'package:flutter/material.dart';
import 'package:woocommerce/models/cart.dart';
import 'package:woocommerce/models/products.dart';

class LineItem extends StatelessWidget {
  WooCartItems product;

  LineItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WooCartItems _product = product;
    return ListTile(
      leading: const Icon(Icons.offline_bolt),
      title: Text(
        _product.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text("ID: " + _product.id.toString()),
      trailing: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'x' + _product.id.toString(),
              textAlign: TextAlign.right,
            ),
          ),
          Text('\$' + _product.price)
        ],
      ),
    );
  }
}
