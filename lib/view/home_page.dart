import 'package:flutter/material.dart';
import 'package:noid_app/View/shop_page.dart';
import 'category_select.dart';
import 'cbd_education.dart';
import 'hero_slider.dart';
import 'order_status.dart';
import 'profile_card.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProfileCard(),
        OrderStatus(),
        HeroSlider(),
      ],
    );
  }
}
