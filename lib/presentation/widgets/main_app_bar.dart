import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight((60.0));

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'logo',
            child: Image.network(
                'https://noidbotanicals.com/wp-content/uploads/2020/08/Asset-2.png',
                fit: BoxFit.cover,
                height: 40),
          ),
        ],
      ),
    );
  }
}
