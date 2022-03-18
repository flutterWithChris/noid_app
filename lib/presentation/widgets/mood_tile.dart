import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MoodTile extends StatelessWidget {
  const MoodTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: .95,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListTile(
            title: const Text(
              " How are you feeling?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: const Icon(
              FontAwesome.heartbeat,
              color: Colors.red,
            ),
            subtitle: Wrap(
              spacing: 50,
              children: [
                Icon(FontAwesomeIcons.smile),
                Icon(FontAwesome5.meh),
                Icon(FontAwesome5.frown),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
