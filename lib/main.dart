import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'category_select.dart';
import 'heroslider.dart';

void main() {
  runApp(const NoidApp());
}

class NoidApp extends StatelessWidget {
  const NoidApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Welcome to Noid Botanicals!', style: TextStyle(color: Colors.black87)),
        ),

        body: Column(
          children: <Widget> [

            Container(height: 75.0, child: CategorySelect(),),

           HeroSlider(), // Announcements
          ],

      ),

      ),

    );

  }

}