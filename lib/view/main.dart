import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noid_app/View/home_page.dart';
import 'package:noid_app/View/shop_page.dart';

import 'cbd_education.dart';

void main() {
  runApp(const NoidApp());
}

class NoidApp extends StatefulWidget {
  const NoidApp({Key? key}) : super(key: key);

  @override
  State<NoidApp> createState() => _NoidAppState();
}

class _NoidAppState extends State<NoidApp> {
  int _currentIndex = 0;

  final screens = [
    Center(child: HomePage()),
    Center(child: ShopPage()),
    Center(child: CBDEducation()),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                  'https://noidbotanicals.com/wp-content/uploads/2020/08/Asset-3.png',
                  fit: BoxFit.cover,
                  height: 45),
            ],
          ),
        ),
        body: screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
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
              icon: Icon(Icons.book),
              label: 'CBD Education',
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              {}
            });
          },
        ),
      ),
    );
  }
}
