import 'package:flutter/material.dart';
import 'package:noid_app/data/repository/user_storage.dart';

class InitialAvatar extends StatefulWidget {
  InitialAvatar({Key? key}) : super(key: key);

  @override
  State<InitialAvatar> createState() => _InitialAvatarState();
}

class _InitialAvatarState extends State<InitialAvatar> {
  String firstName = '';

  String lastName = '';

  Future getFirstName() async {
    final _firstName = await UserStorage.getFirstName() ?? '';
    setState(() {
      firstName = _firstName;
    });
  }

  Future getLastName() async {
    final _lastName = await UserStorage.getLastName() ?? '';
    setState(() {
      lastName = _lastName;
    });
  }

  @override
  Widget build(BuildContext context) {
    getFirstName();
    getLastName();
    String initials = firstName.characters.characterAt(0).toString() +
        lastName.characters.characterAt(0).toString();
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: firstName == '' ? CircularProgressIndicator() : Text(initials),
    );
  }
}
