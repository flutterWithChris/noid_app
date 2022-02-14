import 'package:flutter/material.dart';
import 'package:noid_app/Controller/woo_controller.dart';
import 'package:noid_app/Model/current_user.dart';
import 'package:noid_app/view/home_page.dart';
import 'package:noid_app/view/login_page.dart';
import 'package:woocommerce/models/customer.dart';
import 'login_page.dart';

class ProfileCard extends StatelessWidget {
  WooCustomer currentUser;

  ProfileCard({Key? key, required this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                leading: Icon(Icons.person),
                title: Text(currentUser.firstName + " " + currentUser.lastName),
                subtitle: Text(currentUser.email),
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
