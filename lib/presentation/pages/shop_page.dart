import 'package:flutter/material.dart';
import 'package:noid_app/data/Model/woo_controller.dart';
import 'package:noid_app/presentation/widgets/bottom_nav_bar.dart';
import 'package:noid_app/presentation/widgets/main_app_bar.dart';
import 'package:noid_app/presentation/widgets/product_card.dart';
import 'package:noid_app/presentation/widgets/search_bar.dart';
import 'package:woocommerce/models/products.dart';
import 'package:woocommerce/woocommerce.dart';


class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final WooCommerce _wooController = WooRepo().wooController;

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
        appBar: const MainAppBar(),
        bottomNavigationBar: const BottomNavBar(),
        body: Column(
          children: [
            const IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: SearchBar(),
              ),
            ),
            FutureBuilder(
              future: _getAllProducts(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const IsLoading();
                } else {
                  print("Products: " + snapshot.data.length.toString());
                  return Expanded(
                    child: GridView.builder(
                      itemCount: snapshot.data.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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

class IsLoading extends StatelessWidget {
  const IsLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
