import 'package:flutter/material.dart';
import 'package:noid_app/data/Model/order.dart';


class OrderInfo extends InheritedWidget {
  Order currentOrder = Order(
      orderNumber: 12343,
      orderDate: '12/2/22',
      orderType: 'Online',
      orderStatus: 'Shipped',
      orderTotal: 93.45,
      shippingAddress: '74 PEacock Ave');

  OrderInfo({Key? key, required this.currentOrder})
      : super(key: key, child: currentOrder);

  static OrderInfo? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<OrderInfo>();
  }

  @override
  bool updateShouldNotify(OrderInfo oldWidget) {
    return true;
  }
}
