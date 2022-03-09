import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:noid_app/data/Model/current_user.dart';
import 'package:noid_app/data/Model/order.dart';
import 'package:noid_app/data/Model/user.dart';
import 'package:noid_app/data/repository/user_repo.dart';
import 'package:noid_app/logic/bloc/login_bloc.dart';
import 'package:noid_app/presentation/widgets/bottom_nav_bar.dart';
import 'package:noid_app/presentation/widgets/hero_slider.dart';
import 'package:noid_app/presentation/widgets/main_app_bar.dart';
import 'package:noid_app/presentation/widgets/profile_card.dart';
import 'package:woocommerce/models/customer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //RepositoryProvider.of<UserRepo>(context);
    //print(UserRepo.currentUser.firstName + " set as user");

    final orders = List.generate(
        5,
        (index) => Order(
            orderNumber: 12343,
            orderDate: '12/2/22',
            orderType: 'Online',
            orderStatus: 'Shipped',
            orderTotal: 93.45,
            shippingAddress: '74 Peacock Ave'));

    return Scaffold(
      appBar: const MainAppBar(),
      body: ListView(
        children: [
          const HeroSlider(),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
