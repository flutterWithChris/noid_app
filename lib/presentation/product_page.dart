import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:noid_app/Model/woo_controller.dart';
import 'package:noid_app/presentation/widgets/bottom_nav_bar.dart';
import 'package:noid_app/presentation/widgets/cart_icon.dart';
import 'package:noid_app/presentation/widgets/main_app_bar.dart';
import 'package:woocommerce/models/products.dart';

class ProductPage extends StatefulWidget {
  final WooProduct product;

  const ProductPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final WooProduct _product = widget.product;

    return Scaffold(
      appBar: const MainAppBar(),
      bottomNavigationBar: const BottomNavBar(),
      floatingActionButton: CartIcon(),
      body: ListView(
        children: [
          SizedBox(
            child: Image.network(_product.images[0].src),
          ),
          Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                dense: true,
                title: Text(
                  _product.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24, height: 1.618),
                ),
                trailing: Text(
                  '\$' + _product.regularPrice,
                  style: const TextStyle(fontSize: 18, height: 1.618),
                ),
                subtitle: Wrap(
                  spacing: 5,
                  children: const [
                    Chip(
                      backgroundColor: Colors.white,
                      avatar: Icon(
                        Icons.circle,
                        color: Colors.lightGreen,
                        size: 12,
                      ),
                      label: Text('Full Spectrum'),
                    ),
                    SizedBox(width: 10),
                    Chip(
                      backgroundColor: Colors.cyan,
                      avatar: Icon(
                        Icons.circle,
                        color: Colors.yellow,
                        size: 12,
                      ),
                      label: Text(
                        '30mg / Gummy',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                  children: [
                    ClipRect(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _decreaseButton(quantity),
                          SizedBox(
                            width: 25,
                            child: Text(
                              quantity.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          _incrementButton(quantity),
                          const SizedBox(
                            width: 25,
                          ),
                          ElevatedButton(
                            onPressed: () => {},
                            child: const Text('Add To Cart'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.lightGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Html(data: _product.shortDescription),
            ),
          ),
        ],
      ),
    );
  }

  Widget _incrementButton(int index) {
    return FloatingActionButton(
      elevation: .3,
      mini: true,
      child: const Icon(
        Icons.add,
        color: Colors.black87,
        size: 20,
      ),
      backgroundColor: Colors.white,
      onPressed: () {
        setState(() {
          quantity++;
        });
      },
    );
  }

  Widget _decreaseButton(int index) {
    return FloatingActionButton(
      elevation: .3,
      mini: true,
      child: const Icon(
        Icons.remove,
        color: Colors.black87,
      ),
      backgroundColor: Colors.white,
      onPressed: () {
        setState(() {
          quantity--;
        });
      },
    );
  }
}

void addToCart(WooProduct product, int quantity) {
  wooController.addToMyCart(
      itemId: product.id.toString(), quantity: quantity.toString());
  print(wooController.getMyCartItems());
}
