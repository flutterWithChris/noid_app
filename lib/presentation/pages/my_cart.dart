import 'package:flutter/material.dart';
import 'package:noid_app/presentation/widgets/bottom_nav_bar.dart';
import 'package:noid_app/presentation/widgets/main_app_bar.dart';

class MyCart extends StatefulWidget {
  MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      bottomNavigationBar: BottomNavBar(),
      body: ListView(
        children: [
          SizedBox(
            child: Text('My Cart'),
          ),
        ],
      ),
    );
  }
}
