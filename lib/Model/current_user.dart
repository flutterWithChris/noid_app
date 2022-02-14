import 'package:woocommerce/models/customer.dart';

class CurrentUser extends WooCustomer {
 CurrentUser(WooCustomer currentUser) {
    String avatarUrl = this.avatarUrl;
    Billing billing = this.billing;
    String dateCreated = this.dateCreated;
    String email = this.email;
    String firstName = this.firstName;
    int id = this.id;
    bool isPayingCustomer = this.isPayingCustomer;
    String lastName = this.lastName;
    String role = this.role;
    Shipping shipping = this.shipping;
    String username = this.username;
  }
}
