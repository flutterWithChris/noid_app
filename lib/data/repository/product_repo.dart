import 'package:noid_app/data/providers/wooproduct_api.dart';
import 'package:woocommerce/models/product_category.dart';
import 'package:woocommerce/models/products.dart';
import 'package:woocommerce/woocommerce.dart';

class ProductRepo {
  final WooProductAPI wooProductAPI = WooProductAPI();

  Future<WooProduct> getProduct(int productId) async {
    var product = wooProductAPI.getProduct(productId);
    return product;
  }

  Future<List<WooProductCategory>> getCategories() async {
    var categories = await wooProductAPI.getCategories();
    return categories;
  }

  Future<List<WooProductReview>> getProductReviews(productIds) async {
    var review = await wooProductAPI.getProductReviews(productIds);
    return review;
  }

  Future<List<WooProductTag>> getProductTags(productId) async {
    var tags = await wooProductAPI.getProductTags(productId);
    return tags;
  }

  Future<List<WooProductVariation>> getProductVariations(productId) async {
    var variations = await wooProductAPI.getProductVariations(productId);
    return variations;
  }

  Future<List<WooProduct>> getProducts() async {
    var products = await wooProductAPI.getProducts();
    return products;
  }
}
