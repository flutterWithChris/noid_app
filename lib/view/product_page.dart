import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:noid_app/Controller/woo_controller.dart';
import 'package:noid_app/view/bottom_nav_bar.dart';
import 'package:noid_app/view/main_app_bar.dart';
import 'package:woocommerce/models/products.dart';

class ProductPage extends StatefulWidget {
  final WooProduct product;

  ProductPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  static int quantity = 0;

  @override
  Widget build(BuildContext context) {
    final WooProduct _product = widget.product;

    return Scaffold(
      appBar: MainAppBar(),
      bottomNavigationBar: BottomNavBar(),
      body: ListView(
        children: [
          SizedBox(
            child: Image.network(_product.images[0].src),
          ),
          Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(15, 5, 15, 10),
                dense: true,
                title: Text(
                  _product.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24, height: 1.618),
                ),
                trailing: Text(
                  '\$' + _product.regularPrice,
                  style: TextStyle(fontSize: 18, height: 1.618),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.fromLTRB(3, 15, 0, 0),
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
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            _incrementButton(quantity),
                            SizedBox(
                              width: 25,
                            ),
                            ElevatedButton(
                              onPressed: () => {
                                wooController.addToMyCart(
                                    itemId: _product.id.toString(),
                                    quantity: quantity.toString()),
                              },
                              child: Text('Add To Cart'),
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
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
            child: Wrap(
              children: [
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
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Html(data: _product.shortDescription),
            ),
          )
        ],
      ),
    );
  }

  Widget _incrementButton(int index) {
    return FloatingActionButton(
      elevation: .3,
      mini: true,
      child: Icon(
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
      child: Icon(
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
