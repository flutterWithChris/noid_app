import 'package:noid_app/data/Model/woo_controller.dart';
import 'package:woocommerce/models/cart.dart';
import 'package:woocommerce/models/cart_item.dart';
import 'package:woocommerce/models/product_variation.dart';

class CartApi {
  final _wooController = WooRepo().wooController;

  // * Add to Cart
  void addToCart(String itemId, String quantity) async {
    await _wooController.addToMyCart(
        itemId: itemId, quantity: quantity);
  }

// * Remove Single Item
  void removeFromCart(String itemId) async {
    await _wooController.deleteMyCartItem(key: itemId);
  
  }

// * Clear Entire Cart
  void clearEntireCart() async {
    await _wooController.deleteAllMyCartItems();
  }

// * Get Entire Cart
  Future<WooCart> getCurrentCart() async {
    return await _wooController.getMyCart();
  }

// * Get Item by ID
  Future<WooCartItem> getCartItem(String key) async {
    return await _wooController.getMyCartItemByKey(key);
  }

// * Get Entire Cart as List
  Future<List<WooCartItem>> getAllCartItems() async {
    var cartItems = await _wooController.getMyCartItems();
    return cartItems;
  }

// * Update Cart Item by Key
  void updateCartItem(String key, int id, int quantity) async {
    await _wooController.updateMyCartItemByKey(
        key: key, id: id, quantity: quantity);
  }
}
