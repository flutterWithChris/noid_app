import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noid_app/homepage.dart';

void main() {
  runApp(const NoidApp());
}

class NoidApp extends StatefulWidget {
  const NoidApp({Key? key}) : super(key: key);

  @override
  State<NoidApp> createState() => _NoidAppState();
}

class _NoidAppState extends State<NoidApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Navigator(
        pages: [MaterialPage(child: Homepage())],
        onPopPage: (route, result) {
          if (!route.didPop(result)) return false;

          return true;
        },
      ),
    );
  }
}
