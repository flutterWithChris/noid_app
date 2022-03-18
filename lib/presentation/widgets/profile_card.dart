import 'package:flutter/material.dart';

import 'package:noid_app/data/Model/user.dart';
import 'package:noid_app/data/repository/user_storage.dart';

class ProfileCard extends StatefulWidget {
  String firstName = '';
  String lastName = '';
  String email = '';
  ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  Future getFirstName() async {
    final _firstName = await UserStorage.getFirstName() ?? '';
    setState(() {
      widget.firstName = _firstName;
    });
  }

  Future getLastName() async {
    final _lastName = await UserStorage.getLastName() ?? '';
    setState(() {
      widget.lastName = _lastName;
    });
  }

  Future getEmail() async {
    final _email = await UserStorage.getEmail() ?? '';
    setState(() {
      widget.email = _email;
    });
  }

  @override
  Widget build(BuildContext context) {
    getFirstName();
    getLastName();
    getEmail();
    String initials = widget.firstName.characters.characterAt(0).toString() +
        widget.lastName.characters.characterAt(0).toString();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 85,
        child: Card(
          elevation: 0,
          color: Colors.transparent,
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(initials),
                ),
                title: Text(widget.firstName + " " + widget.lastName),
                subtitle: Text(widget.email),
              ),
              const Flexible(
                child: FractionallySizedBox(
                  widthFactor: 0.65,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.lightGreen),
                    value: 0.7,
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
