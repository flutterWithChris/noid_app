import 'package:flutter/material.dart';

class MenuItem extends StatefulWidget {
  String itemName = '';
  Icon leadingIcon;
  void Function() onTap;

  MenuItem({
    Key? key,
    required this.itemName,
    required this.leadingIcon,
    required this.onTap,
  }) : super(key: key);

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title:
          Text(widget.itemName, style: TextStyle(fontWeight: FontWeight.bold)),
      leading: widget.leadingIcon,
      trailing: Icon(Icons.arrow_forward),
      onTap: widget.onTap,
    );
  }
}
