import 'package:flutter/material.dart';

class LoginAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LoginAppBar({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight((60.0));

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
    );
  }
}
