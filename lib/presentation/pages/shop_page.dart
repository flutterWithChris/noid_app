import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noid_app/data/repository/product_repo.dart';
import 'package:noid_app/logic/bloc/shop/shop_bloc.dart';
import 'package:noid_app/presentation/widgets/bottom_nav_bar.dart';
import 'package:noid_app/presentation/widgets/category_select.dart';
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
  ShopBloc shopBloc = ShopBloc();

  Future<List<WooProduct>> _getAllProducts() async {
    var products = await ProductRepo().getProducts();
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
          mainAxisSize: MainAxisSize.min,
          children: [
            const IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: SearchBar(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 15),
              child: CategorySelect(),
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 0.70),
                      itemBuilder: (context, index) {
                        final product = snapshot.data[index];
                        return ProductCard(currentProduct: product);
                      },
                    ),
                  );
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
