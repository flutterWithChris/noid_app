import 'package:flutter/material.dart';
import 'package:noid_app/View/category_select.dart';
import 'package:noid_app/view/bottom_nav_bar.dart';
import 'package:noid_app/view/flavor_chips.dart';
import 'package:noid_app/view/goal_chips.dart';
import 'package:noid_app/view/main_app_bar.dart';
import 'package:noid_app/view/spectrum_chips.dart';
import 'package:noid_app/view/strength_chips.dart';
import 'search_bar.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(),
        bottomNavigationBar: BottomNavBar(index: 1),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              SizedBox(
                height: 70.0,
                child: SearchBar(),
              ),
              const CategorySelect(),
              const GoalChips(),
              const SpectrumChips(),
              const FlavorChips(),
            ],
          ),
        ));
  }
}
