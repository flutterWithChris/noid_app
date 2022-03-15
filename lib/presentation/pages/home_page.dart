import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:noid_app/data/Model/order.dart';
import 'package:noid_app/data/repository/user_repo.dart';
import 'package:noid_app/data/repository/user_storage.dart';
import 'package:noid_app/presentation/widgets/bottom_nav_bar.dart';
import 'package:noid_app/presentation/widgets/hero_slider.dart';
import 'package:noid_app/presentation/widgets/main_app_bar.dart';
import 'package:noid_app/presentation/widgets/profile_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    UserRepo userRepo = RepositoryProvider.of<UserRepo>(context);
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
          ProfileCard(),
          ReminderTile(),
          const HeroSlider(),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class ReminderTile extends StatelessWidget {
  const ReminderTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: .9,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListTile(
            title: const Text(
              "Have you taken CBD today?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: const Icon(Icons.timer),
            subtitle: Wrap(
              children: [
                TextButton(
                    onPressed: () => print('Yes Pressed'),
                    child: Text('Yes, I Did!')),
                TextButton(
                    onPressed: () => print('Yes Pressed'),
                    child: Text('No, I Didn\'t.')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
