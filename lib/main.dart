import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noid_app/order_status.dart';
import 'package:noid_app/profile_card.dart';
import 'category_select.dart';
import 'hero_slider.dart';
import 'profile_card.dart';
import 'bottom_navigation.dart';

void main() {
  runApp(const NoidApp());
}

class NoidApp extends StatelessWidget {
  const NoidApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Welcome to Noid Botanicals!',
              style: TextStyle(color: Colors.black87)),
        ),
        body: ListView(
          children: <Widget>[
            ProfileCard(),
            OrderStatus(),
            HeroSlider(), // Announcements
          ],
        ),
        bottomNavigationBar: BottomNavigation(),
      ),
    );
  }
}
