import 'package:flutter/material.dart';
import 'package:noid_app/View/shop_page.dart';
import 'package:noid_app/routes/route.dart';
import 'package:noid_app/view/bottom_nav_bar.dart';
import 'package:noid_app/view/main_app_bar.dart';
import 'hero_slider.dart';
import 'my_account.dart';
import 'order_status.dart';
import 'profile_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: ListView(
        children: [
          const ProfileCard(),
          const OrderStatus(),
          const HeroSlider(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(index: 0),
    );
  }
}
