import 'package:flutter/material.dart';
import 'package:noid_app/Controller/woo_controller.dart';
import 'package:noid_app/View/category_select.dart';
import 'package:noid_app/view/bottom_nav_bar.dart';
import 'package:noid_app/view/flavor_chips.dart';
import 'package:noid_app/view/goal_chips.dart';
import 'package:noid_app/view/main_app_bar.dart';
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
  WooCommerce _wooController = wooController;

  List<WooProduct> allProducts = [];

  getProducts() async {
    allProducts = await _wooController.getProducts();
    setState(() {});
    print(_wooController.toString());
  }

  @override
  Widget build(BuildContext context) {
    getProducts();
    final testProduct = allProducts[9];

    return Scaffold(
        appBar: MainAppBar(),
        bottomNavigationBar: BottomNavBar(),
        body: Column(
          children: [
            IntrinsicHeight(
              child: SearchBar(),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.70),
                itemBuilder: (context, index) => Column(
                  children: [
                    SizedBox(
                        height: 190,
                        child: Image.network(testProduct.images[0].src)),
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Card(
                        child: ListTile(
                          dense: true,
                          title: Text(
                            testProduct.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: Icon(Icons.arrow_forward, size: 15),
                          subtitle: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: Colors.lightGreen,
                                size: 12,
                              ),
                              Text(' Full Spectrum'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
