import 'package:noid_app/data/providers/cart_api.dart';
import 'package:woocommerce/models/cart.dart';
import 'package:woocommerce/models/cart_item.dart';

class CartRepo {
  final CartApi _cartApi = CartApi();

  void addToCart(String itemId, String quantity) {
    _cartApi.addToCart(itemId, quantity);
  }

  void removeFromCart(String itemId) {
    _cartApi.removeFromCart(itemId);
  }

  void clearMyCart() {
    _cartApi.clearEntireCart();
  }

  Future<WooCart> getMyCart() async {
    return await _cartApi.getCurrentCart();
  }

  Future<WooCartItem> getCartItem(String key) async {
    return await _cartApi.getCartItem(key);
  }

  Future<List<WooCartItem>> getAllCartItems() async {
    var items = await _cartApi.getAllCartItems();
    return items;
  }

  void updateCartItem(String key, int id, int quantity) {
    _cartApi.updateCartItem(key, id, quantity);
  }
}
