import 'package:noid_app/data/Model/user.dart';
import 'package:noid_app/data/Model/woo_controller.dart';
import 'package:noid_app/data/providers/user_api.dart';
import 'package:noid_app/data/repository/user_storage.dart';
import 'package:woocommerce/models/customer.dart';
import 'package:woocommerce/woocommerce.dart';

class UserRepo {
  final UserAPI userAPI = UserAPI();

  Future<WooCustomer?> loginUser(String username, String password) async {
    print("User Repo Sign In Called");
    WooCustomer? user = await userAPI.loginWooCustomer(username, password);
    if (user != null) {
      UserStorage.setUserId(user.id.toString());
      UserStorage.setUsername(user.username);
      UserStorage.setEmail(user.email);
      UserStorage.setFirstName(user.firstName);
      UserStorage.setLastName(user.lastName);
      UserStorage.setUserToken(userAPI.getToken());
    }

    print("User Signed In: $username");
    return user;
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
