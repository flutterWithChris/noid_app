import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noid_app/data/Model/cart_model.dart';
import 'package:noid_app/data/repository/product_repo.dart';
import 'package:noid_app/logic/bloc/cart/cart_bloc.dart';
import 'package:woocommerce/models/cart_item.dart';
import 'package:woocommerce/models/products.dart';

class CartLineItem extends StatelessWidget {
  int productId;
  ProductRepo productRepo = ProductRepo();

  CartLineItem({
    Key? key,
    required this.productId,
  }) : super(key: key);

  _getProduct() async {
    WooProduct item = await productRepo.getProduct(productId);
    return item;
  }

  @override
  Widget build(BuildContext context) {
    CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
    return FutureBuilder(
        future: _getProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var currentProduct = snapshot.data as WooProduct;
          double subtotal = 0.00;
          if (1 > 0) {
            double sub = double.parse(currentProduct.price);
            subtotal = sub;
          }

          double.parse(currentProduct.price);
          return ListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            leading: Image.network(currentProduct.images.first.src),
            title: Text(
              currentProduct.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("ID: " + currentProduct.id.toString()),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Qty: x ",
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(subtotal.toStringAsFixed(2)),
              ],
            ),
          );
        });
  }
}
