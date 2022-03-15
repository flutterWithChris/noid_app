import 'package:noid_app/data/Model/user.dart';
import 'package:noid_app/data/Model/woo_controller.dart';
import 'package:noid_app/data/providers/user_api.dart';
import 'package:woocommerce/models/customer.dart';
import 'package:woocommerce/woocommerce.dart';

class UserRepo {
  final UserAPI userAPI = UserAPI();

  Future<User> loginUser(String username, String password) async {
    print("User Repo Sign In Called");
    var user = await userAPI.loginWooCustomer(username, password);
    final User _currentUser = User(
        userId: user?.id.toString(),
        username: user?.username,
        firstName: user?.firstName,
        lastName: user?.lastName,
        email: user?.email,
        shippingAddress: user?.shipping.address1,
        billingAddress: user?.billing.address1);
    print("User Signed In: $username");
    return _currentUser;
  }

  Future<bool> isLoggedIn() async {
    var res = await userAPI.isSignedIn();
    return res;
  }

  void logOut() {
    userAPI.signOut();
    print("**User Logged Out**");
  }

  // Get Current User
  /* Future<User> getCurrentUser() async {
    await wooController.c
  } */

}
