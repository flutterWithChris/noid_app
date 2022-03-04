import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noid_app/presentation/screens/home_page.dart';
import 'package:noid_app/presentation/screens/my_account.dart';
import 'package:noid_app/presentation/screens/shop_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

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
              Get.to(() => const HomePage());
            }
            break;

          case 1:
            {
              Get.to(() => const ShopPage());
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
          icon: const Icon(Icons.home),
          title: const Text('Home'),
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.shopping_basket),
          title: const Text('Shop Now'),
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.account_circle_rounded),
          title: const Text('My Account'),
        ),
      ],
    );
  }
}
