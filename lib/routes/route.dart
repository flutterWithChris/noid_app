import 'package:flutter/material.dart';
import 'package:noid_app/view/billing_info.dart';
import 'package:noid_app/view/home_page.dart';
import 'package:noid_app/view/login_page.dart';
import 'package:noid_app/view/my_account.dart';
import 'package:noid_app/view/my_subscriptions.dart';
import 'package:noid_app/view/shipping_addresses.dart';
import 'package:noid_app/view/shop_page.dart';

class RouteManager {
  static const String loginPage = '/';
  static const String homePage = '/homePage';
  static const String shopPage = '/shopPage';
  static const String myAccount = '/myAccount';
  static const String myOrders = '/myOrders';
  static const String mySubscriptions = '/mySubscriptions';
  static const String billingInfo = '/billingInfo';
  static const String shippingAddresses = '/shippingAddresses';
  static const String orderDetails = '/orderDetails';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(
          builder: (context) => LoginPage(),
        );
      case homePage:
        return MaterialPageRoute(
          builder: (context) => HomePage(),
        );

      case shopPage:
        return MaterialPageRoute(
          builder: (context) => ShopPage(),
        );

      case myAccount:
        return MaterialPageRoute(
          builder: (context) => MyAccount(),
        );

      case mySubscriptions:
        return MaterialPageRoute(builder: (context) => MySubscriptions());

      case billingInfo:
        return MaterialPageRoute(builder: (context) => BillingInfo());

      case shippingAddresses:
        return MaterialPageRoute(builder: (context) => ShippingAddresses());

      default:
        throw FormatException('Route not found! Check routes again!');
    }
  }
}
