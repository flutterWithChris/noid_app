import 'package:flutter/material.dart';
import 'package:noid_app/Controller/woo_controller.dart';
import 'package:noid_app/View/category_select.dart';
import 'package:noid_app/view/bottom_nav_bar.dart';
import 'package:noid_app/view/flavor_chips.dart';
import 'package:noid_app/view/goal_chips.dart';
import 'package:noid_app/view/main_app_bar.dart';
import 'package:noid_app/view/product_card.dart';
import 'package:noid_app/view/spectrum_chips.dart';
import 'package:woocommerce/models/products.dart';
import 'package:woocommerce/woocommerce.dart';
import 'search_bar.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final WooCommerce _wooController = wooController;

  Future<List<WooProduct>> _getAllProducts() async {
    var products = await _wooController.getProducts();
    List<WooProduct> allProducts = [];
    for (var p in products) {
      WooProduct product = p;
      allProducts.add(p);
    }
    return allProducts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(),
        bottomNavigationBar: BottomNavBar(),
        body: Column(
          children: [
            IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchBar(),
              ),
            ),
            FutureBuilder(
              future: _getAllProducts(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return isLoading();
                } else {
                  print("Products: " + snapshot.data.length.toString());
                  return Expanded(
                    child: GridView.builder(
                      itemCount: snapshot.data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 0.70),
                      itemBuilder: (context, index) {
                        final product = snapshot.data[index];
                        return ProductCard(currentProduct: product);
                      },
                    ),
                  );

                  /*   return Container(
                      child: Text("Nope"),
                    );*/

                }
              },
            ),
          ],
        ));
  }
}

class isLoading extends StatelessWidget {
  const isLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
