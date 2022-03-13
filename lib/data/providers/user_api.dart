import 'package:get/get.dart';
import 'package:noid_app/data/Model/woo_controller.dart';
import 'package:noid_app/presentation/pages/home_page.dart';
import 'package:woocommerce/models/customer.dart';
import 'package:woocommerce/woocommerce.dart';

class UserAPI {
  final WooCommerce _wooController = WooRepo().wooController;

  Future<WooCustomer?> loginWooCustomer(String _email, String _password) async {
    var _currentUser = await _wooController.loginCustomer(
        username: _email, password: _password);
    bool isLoggedIn = await _wooController.isCustomerLoggedIn();
    try {
      // Check if user is logged in
      if (_currentUser is WooCustomer) {
        final token = _wooController.authenticateViaJWT(
            username: _email, password: _password);
        print(_email +
            "testt logged in! " +
            _wooController.fetchLoggedInUserId().toString());

        return _currentUser;

        //Push to homepage
        /* await Get.to(() => const HomePage(),
                                              arguments: {'currentUser': _currentUser});*/

      } else if (_currentUser.runtimeType != WooCustomer) {
        print("Login Error");
        return null;
      }
    } on Exception catch (e) {
      //print(e);
    }
  }

  // Check Sign-In Status
  Future<bool> isSignedIn() async {
    var response = await WooRepo().wooController.isCustomerLoggedIn();
    return response;
  }

  void signOut() {
    _wooController.logUserOut();
  }
}
