import 'package:noid_app/data/Model/user.dart';
import 'package:noid_app/data/Model/woo_controller.dart';
import 'package:noid_app/data/providers/user_api.dart';
import 'package:noid_app/data/repository/user_storage.dart';
import 'package:woocommerce/models/customer.dart';
import 'package:woocommerce/woocommerce.dart';

class UserRepo {
  final UserAPI userAPI = UserAPI();

  Future<User?> loginUser(String username, String password) async {
    print("User Repo Sign In Called");
    await userAPI.loginWooCustomer(username, password);
  }

  Future<bool> isLoggedIn() async {
    var res = await userAPI.isSignedIn();
    return res;
  }

  void logOut() {
    userAPI.signOut();
    print("**User Logged Out**");
  }

  Future<Billing> getBillingInfo(int id) {
    return userAPI.getBillingInfo(id);
  }

  Future<Shipping> getShippingInfo(int id) {
    return userAPI.getShippingInfo(id);
  }

  Future<List<WooOrder>> getOrders(int id) {
    return userAPI.getOrders(id);
  }

  // Get Current User
  /* Future<User> getCurrentUser() async {
    await wooController.c
  } */

}
