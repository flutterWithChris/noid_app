import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:noid_app/data/repository/user_repo.dart';
import 'package:noid_app/presentation/pages/login_page.dart';
import 'package:noid_app/presentation/pages/home_page.dart';
import 'package:noid_app/presentation/screens/my_account.dart';
import 'package:noid_app/presentation/pages/shop_page.dart';
import 'package:noid_app/routes/route.dart';
import 'package:wp_json_api/wp_json_api.dart';

void main() {
  runApp(const NoidApp());
  WPJsonAPI.instance
      .initWith(baseUrl: "https://wordpress-513850-2524483.cloudwaysapps.com/");
}

class NoidApp extends StatefulWidget {
  const NoidApp({Key? key}) : super(key: key);

  @override
  State<NoidApp> createState() => _NoidAppState();
}

class _NoidAppState extends State<NoidApp> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepo(),
      child: GetMaterialApp(
        getPages: [
          GetPage(name: "/", page: () => LoginPage()),
          GetPage(name: "/home'", page: () => const HomePage()),
          GetPage(name: "/shop", page: () => const ShopPage()),
          GetPage(name: "/my-account", page: () => MyAccount()),
        ],
        initialRoute: '/',
      ),
    );
  }
}
