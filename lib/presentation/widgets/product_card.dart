import 'package:flutter/material.dart';
import 'package:noid_app/presentation/screens/product_page.dart';
import 'package:woocommerce/models/products.dart';

class ProductCard extends StatefulWidget {
  final WooProduct currentProduct;

  const ProductCard({Key? key, required this.currentProduct}) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 190,
            child: Image.network(widget.currentProduct.images[0].src)),
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Card(
            child: ListTile(
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductPage(product: widget.currentProduct),
                    ))
              },
              dense: true,
              title: Text(
                widget.currentProduct.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.arrow_forward, size: 15),
              subtitle: Row(
                children: const [
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
        )
      ],
    );
  }
}
