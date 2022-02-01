import 'package:flutter/material.dart';
import 'package:noid_app/View/category_select.dart';
import 'package:noid_app/view/flavor_chips.dart';
import 'package:noid_app/view/goal_chips.dart';
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 70.0,
            child: SearchBar(),
          ),
          CategorySelect(),
          GoalChips(),
          StrengthChips(),
          SpectrumChips(),
          FlavorChips(),
        ],
      ),
    );
  }
}
