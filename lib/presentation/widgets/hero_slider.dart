import 'package:flutter/material.dart';
import 'package:noid_app/data/Model/woo_controller.dart';
import 'package:woocommerce/woocommerce.dart';

class HeroSlider extends StatelessWidget {
  const HeroSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WooCommerce _controller = WooRepo().getWooController;
    // TODO: implement build
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 360,
        child: Column(children: <Widget>[
          Image.network(
              'https://noidbotanicals.com/wp-content/uploads/2021/10/20211005143841_IMG_3843-1-855x500.jpg'),
          // ignore: prefer_const_constructors
          ListTile(
            title: const Text('Does CBD Have Calories?',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const Text('Counting the calories in each different CBD product.'),
          const ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: null, child: Text('Read More'))
            ],
          ),
        ]),
      ),
    );
  }
}
