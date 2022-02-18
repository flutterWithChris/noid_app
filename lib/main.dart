import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:noid_app/routes/route.dart';
import 'package:noid_app/view/home_page.dart';
import 'package:noid_app/view/login_page.dart';
import 'package:noid_app/view/my_account.dart';
import 'package:noid_app/view/shop_page.dart';
import 'package:wp_json_api/wp_json_api.dart';

void main() {
  runApp(NoidApp());
  WPJsonAPI.instance.initWith(baseUrl: "https://noidbotanicals.com");
}

class NoidApp extends StatefulWidget {
  NoidApp({Key? key}) : super(key: key);

  @override
  State<NoidApp> createState() => _NoidAppState();
}

class _NoidAppState extends State<NoidApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: "/", page: () => LoginPage()),
        GetPage(name: "/home'", page: () => HomePage()),
        GetPage(name: "/shop", page: () => ShopPage()),
        GetPage(name: "/my-account", page: () => MyAccount()),
      ],
      initialRoute: '/',
    );
  }
}
