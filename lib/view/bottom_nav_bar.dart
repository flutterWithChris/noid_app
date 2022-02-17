import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noid_app/view/home_page.dart';
import 'package:noid_app/view/my_account.dart';
import 'package:noid_app/view/shop_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  static int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
      currentIndex: _currentIndex,
      onTap: (i) => setState(() {
        _currentIndex = i;
        print(_currentIndex);
        switch (_currentIndex) {
          case 0:
            {
              Get.to(() => HomePage());
            }
            break;

          case 1:
            {
              Get.to(() => ShopPage());
            }
            break;

          case 2:
            {
              Get.to(() => MyAccount());
            }
        }
      }),
      items: [
        SalomonBottomBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        SalomonBottomBarItem(
          icon: Icon(Icons.shopping_basket),
          title: Text('Shop Now'),
        ),
        SalomonBottomBarItem(
          icon: Icon(Icons.account_circle_rounded),
          title: Text('My Account'),
        ),
      ],
    );
  }
}
