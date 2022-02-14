import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noid_app/Model/order.dart';
import 'package:noid_app/routes/route.dart';
import 'package:noid_app/view/order_info.dart';
import 'package:wp_json_api/wp_json_api.dart';

import 'cbd_education.dart';

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
    return const MaterialApp(
      initialRoute: RouteManager.loginPage,
      onGenerateRoute: RouteManager.generateRoute,
    );
  }
}
