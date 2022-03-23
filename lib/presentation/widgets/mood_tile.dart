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
        color: Colors.cyan,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(
                child: Text(
                  "How are you feeling?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.2,
                ),
                /* leading: const Icon(
                  FontAwesome.heartbeat,
                  color: Colors.red,
                ), */
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                child: Container(
                  width: 275,
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    //spacing: 50,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const Icon(
                          FontAwesomeIcons.smile,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                          height: 30,
                          child: const VerticalDivider(
                            thickness: 2,
                            color: Colors.white70,
                          )),
                      InkWell(
                        onTap: () {},
                        child: const Icon(
                          FontAwesome5.meh,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                          height: 30,
                          child: const VerticalDivider(
                            thickness: 2,
                            color: Colors.white70,
                          )),
                      InkWell(
                        onTap: () {},
                        child: const Icon(
                          FontAwesome5.frown,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
