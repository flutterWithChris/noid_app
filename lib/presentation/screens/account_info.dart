import 'dart:async';
import 'package:flutter/material.dart';
import 'package:noid_app/data/Model/user.dart';
import 'package:noid_app/data/repository/user_repo.dart';
import 'package:noid_app/presentation/widgets/bottom_nav_bar.dart';
import 'package:noid_app/presentation/widgets/main_app_bar.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({Key? key}) : super(key: key);

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController stateController = TextEditingController();

  TextEditingController zipController = TextEditingController();

  TextEditingController companyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _currentUser = UserRepo().getCurrentUser;
    firstNameController.text = _currentUser.firstName!;
    lastNameController.text = _currentUser.lastName!;
    emailController.text = _currentUser.email!;
    void dispose() {
      firstNameController.dispose();
      lastNameController.dispose();
      emailController.dispose();
    }

    return Scaffold(
      appBar: const MainAppBar(),
      bottomNavigationBar: const BottomNavBar(),
      body: FutureBuilder(
          future: _currentUser,
          builder: (context, snapshot) {
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const Center(
                        heightFactor: 2.0,
                        child: Text(
                          "Account Info",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: .9,
                        child: Wrap(
                          runSpacing: 20,
                          children: [
                            // HEADING
                            TextFormField(
                              controller: firstNameController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  label: Text('First Name')),
                            ),
                            TextFormField(
                              controller: lastNameController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  label: Text('Last Name')),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  label: Text('Email Address')),
                              controller: emailController,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
