import 'package:woocommerce/models/customer.dart';

class CurrentUser extends WooCustomer {
  static final CurrentUser _thisUser = CurrentUser._();
  CurrentUser._();

  CurrentUser();

  static WooCustomer? _loggedInUser;

  static WooCustomer? get instance => _loggedInUser;

  void setUser(user) {
    _loggedInUser = user;

  }

  
}
