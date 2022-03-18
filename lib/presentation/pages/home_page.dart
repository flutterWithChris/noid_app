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
import 'package:noid_app/presentation/widgets/profile_card.dart';
import 'package:noid_app/presentation/widgets/reminder_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String firstName = '';
  Future getFirstName() async {
    final _firstName = await UserStorage.getFirstName() ?? '';
    firstName = _firstName;
    return firstName;
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
              padding: const EdgeInsets.fromLTRB(25, 15, 0, 10),
              child: SizedBox(
                child: FutureBuilder(
                    future: getFirstName(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Text(
                          // TODO: Put this into an Expanded. So Size can be scaled for longer names.
                          "Hey, $firstName!",
                          textScaleFactor: 5.0,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        );
                      } else {
                        return Container();
                      }
                    }),
              ),
            ),
            // ProfileCard(),
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
