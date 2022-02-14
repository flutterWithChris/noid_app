import 'package:flutter/material.dart';
import 'package:noid_app/View/home_page.dart';
import 'package:noid_app/View/my_account.dart';
import 'package:noid_app/View/shop_page.dart';
import 'package:noid_app/routes/route.dart';
import 'package:noid_app/view/login_page.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  static int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_basket),
          label: 'Shop Now',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_rounded),
          label: 'My Account',
        ),
      ],
      onTap: (index) {
        setState(() {
          _currentIndex = index;

          switch (index) {
            case 0:
              {
                Navigator.of(context).pushNamed(RouteManager.homePage);
              }
              break;
            case 1:
              {
                Navigator.of(context).pushNamed(RouteManager.shopPage);
              }
              break;

            case 2:
              {
                Navigator.of(context).pushNamed(RouteManager.myAccount);
              }
              break;
            default:
              {
                throw FormatException('No Route Found!');
              }
          }
        });
      },
    );
  }
}
