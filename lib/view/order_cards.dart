import 'package:flutter/material.dart';

class OrderCards extends InheritedWidget {
  OrderCards({Key? key, required this.child}) : super(key: key, child: child);

  final Widget child;

  static OrderCards? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<OrderCards>();
  }

  @override
  bool updateShouldNotify(OrderCards oldWidget) {
    return true;
  }
}