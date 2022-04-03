import 'package:woocommerce/models/cart.dart';
import 'package:woocommerce/models/cart_item.dart';

import 'package:noid_app/data/Model/cart_model.dart';
import 'package:noid_app/data/providers/cart_api.dart';

class CartRepo {
  final Cart cart = Cart();
  get getCart => this.cart;

  void addToCart(int itemId, int quantity) {
    cart.addItemToCart(itemId, quantity);
  }

  void removeFromCart(int itemId, int quantity) {
    cart.removeFromMyCart(itemId, quantity);
  }

  int getItemCount() {
    print('Cart Count: ' + cart.getItemcount.toString());
    return cart.getItemcount;
  }

  double getTotal() {
    return cart.getTotal;
  }

// ! Clear Cart Function
  Map<int, int> getAllCartItems() {
    var items = cart.getItemList();
    return items;
  }
}
