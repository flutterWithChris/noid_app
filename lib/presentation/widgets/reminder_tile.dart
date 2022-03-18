import 'package:flutter/material.dart';

class ReminderTile extends StatelessWidget {
  const ReminderTile({Key? key}) : super(key: key);

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
              " Did you take your CBD today?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: const Icon(Icons.calendar_today_rounded),
            subtitle: Wrap(
              children: [
                TextButton(
                    onPressed: () => print('Yes Pressed'),
                    child: const Text(
                      'Yes, I Did!',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                TextButton(
                    onPressed: () => print('Yes Pressed'),
                    child: const Text(
                      'No, I Didn\'t.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
