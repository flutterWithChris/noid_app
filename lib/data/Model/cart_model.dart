import 'package:woocommerce/models/cart_item.dart';
import 'package:woocommerce/models/products.dart';

class Cart {
  static int itemcount = 0;

  int get getItemcount => itemcount;

  double subtotal = 0;
  double total = 0;
  double tax = 0;
  double shipping = 0;
  List<WooProduct> items = [];
  Map<int, int> itemList = {};

  Map<int, int> getItemList() {
    return itemList;
  }

  set setItemList(final _itemList) => this.itemList = _itemList;

  void addItemToCart(int productId, int qty) {
    itemList.addAll({productId: qty});
    itemcount + 1;
  }

  get getSubtotal => this.subtotal;

  set setSubtotal(subtotal) => this.subtotal = subtotal;

  get getTotal => total;

  set setTotal(total) => this.total = total;

  get getTax => this.tax;

  set setTax(tax) => this.tax = tax;

  get getShipping => this.shipping;

  set setShipping(shipping) => this.shipping = shipping;

  void removeFromMyCart(int id, int quantity) {
    for (var i = 0; i < quantity; i++) {
      items.remove(id);
    }
  }

  void increaseTotal(String price) {
    double itemPrice = double.parse(price);
    total + itemPrice;
  }

  void decreaseTotal(String price) {
    double itemPrice = double.parse(price);
    total - itemPrice;
  }
}
