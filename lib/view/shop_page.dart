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
  bool isLoading = false;
  WooCommerce _wooController = wooController;

  List<WooProduct> allProducts = [];

  getProducts() async {
    setState(() {
      isLoading = true;
    });
    allProducts = await _wooController.getProducts();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    getProducts();

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
            isLoading
                ? Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 0.70),
                      itemBuilder: (context, index) {
                        final product = allProducts[index];
                        return ProductCard(currentProduct: product);
                      },
                    ),
                  )
                : Center(child: CircularProgressIndicator()),
          ],
        ));
  }
}
