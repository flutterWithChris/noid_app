import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noid_app/data/Model/woo_controller.dart';
import 'package:woocommerce/woocommerce.dart';

class WooProductAPI {
  final WooCommerce _wooController = WooRepo().getWooController;

  Future<WooProduct> getProduct(int productId) {
    var currentProduct = _wooController.getProductById(id: productId);
    return currentProduct;
  }

  Future<List<WooProduct>> getProducts() async {
    var products = await _wooController.getProducts();
    return products;
  }

  Future<List<WooProductVariation>> getProductVariations(int productId) async {
    var variations =
        await _wooController.getProductVariations(productId: productId);
    return variations;
  }

  Future<List<WooProductCategory>> getCategories() async {
    var categories = await _wooController.getProductCategories();
    return categories;
  }

  Future<List<WooProductAttribute>> getProductAttributes() async {
    var attributes = await _wooController.getProductAttributes();
    return attributes;
  }

  Future<List<WooProductTag>> getProductTags(int productId) async {
    var tags = await _wooController.getProductTags(product: productId);
    return tags;
  }

  Future<List<WooProductReview>> getProductReviews(List<int> productIds) async {
    var reviews = await _wooController.getProductReviews(product: productIds);
    return reviews;
  }
}
