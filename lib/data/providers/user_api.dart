import 'package:get/get.dart';
import 'package:noid_app/data/Model/woo_controller.dart';
import 'package:noid_app/presentation/pages/home_page.dart';
import 'package:woocommerce/models/customer.dart';
import 'package:woocommerce/woocommerce.dart';

class UserAPI {
  final WooCommerce _wooController = WooRepo().wooController;

  String getToken() {
    return _wooController.authToken;
  }

  Future<WooCustomer?> loginWooCustomer(String _email, String _password) async {
    WooCustomer? _currentUser = await _wooController.loginCustomer(
        username: _email, password: _password);

    if (_currentUser is WooCustomer) {
      print('logged in *API');
      return _currentUser;
    } else if (_currentUser is String) {
      print('not logged in (API)');
      print(_currentUser.toString());
      return null;
    }
  }

  // Check Sign-In Status
  Future<bool> isSignedIn() async {
    var response = await WooRepo().wooController.isCustomerLoggedIn();
    return response;
  }

  Future<Billing> getBillingInfo(int id) async {
    WooCustomer user = await WooRepo().wooController.getCustomerById(id: id);
    return user.billing;
  }

  Future<Shipping> getShippingInfo(int id) async {
    WooCustomer user = await WooRepo().wooController.getCustomerById(id: id);
    return user.shipping;
  }

  Future<List<WooOrder>> getOrders(int id) async {
    List<WooOrder> orders =
        await WooRepo().wooController.getOrders(customer: id);
    return orders;
  }

  void signOut() {
    _wooController.logUserOut();
  }
}
