import 'package:flutter/material.dart';
import 'package:noid_app/view/home_page.dart';
import 'package:noid_app/view/my_account.dart';
import 'package:noid_app/view/shop_page.dart';

class RouteManager {
  static const String homePage = '/';
  static const String shopPage = '/shopPage';
  static const String myAccount = '/myAccount';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
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

      default:
        throw FormatException('Route not found! Check routes again!');
    }
  }
}
