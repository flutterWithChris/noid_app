import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:noid_app/data/Model/order.dart';
import 'package:noid_app/data/repository/user_repo.dart';
import 'package:noid_app/data/repository/user_storage.dart';
import 'package:noid_app/presentation/widgets/bottom_nav_bar.dart';
import 'package:noid_app/presentation/widgets/hero_slider.dart';
import 'package:noid_app/presentation/widgets/main_app_bar.dart';
import 'package:noid_app/presentation/widgets/mood_tile.dart';
import 'package:noid_app/presentation/widgets/order_card.dart';
import 'package:noid_app/presentation/widgets/profile_card.dart';
import 'package:noid_app/presentation/widgets/reminder_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woocommerce/models/order.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<String> getFirstName() async {
    final _firstName = await UserStorage.getFirstName() ?? '';
    String firstName = _firstName;
    return firstName;
  }

  Future<WooOrder> _getLastOrder() async {
    var userId = await UserStorage.getUserId();
    var orders = await UserRepo().getOrders(int.parse(userId!));

    return orders.first;
  }

  @override
  Widget build(BuildContext context) {
    getFirstName();
    return Scaffold(
      appBar: const MainAppBar(),
      body: Scrollbar(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: FutureBuilder(
                  future: getFirstName(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      var firstName = snapshot.data as String;
                      return SizedBox(
                        height: 75,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            "Hey, $firstName!",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
            ),
            // ProfileCard(),
            FutureBuilder(
              future: _getLastOrder(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return OrderCard(order: snapshot.data as WooOrder);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            const ReminderTile(),
            const MoodTile(),
            const HeroSlider(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
