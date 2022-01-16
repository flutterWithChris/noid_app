import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 85,
        child: Card(
          elevation: 0,
          color: Colors.transparent,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Christian Vergara'),
                subtitle: Text('CBD Connoseiur '),
              ),
              Flexible(
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
