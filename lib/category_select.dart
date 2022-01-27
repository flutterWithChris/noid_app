import 'package:flutter/material.dart';

class CategorySelect extends StatelessWidget {
  const CategorySelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Container(
          width: 75.0,
          height: 75.0,
          color: Colors.red,
          child: const Text('CBD Oil', textAlign: TextAlign.center),
        ),
        Container(
          width: 75.0,
          height: 75.0,
          color: Colors.blue,
        ),
        Container(
          width: 75.0,
          height: 75.0,
          color: Colors.amber,
        ),
        Container(
          width: 75.0,
          height: 75.0,
          color: Colors.deepPurple,
        ),
        Container(
          width: 75.0,
          height: 75.0,
          color: Colors.pinkAccent,
        ),
        Container(
          width: 75.0,
          height: 75.0,
          color: Colors.deepOrange,
        ),
      ],
    );
  }
}
