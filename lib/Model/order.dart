import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  int orderNumber;
  String orderDate, orderType, shippingAddress, orderStatus;
  double orderTotal;

  Order(
      {Key? key,
      required this.orderNumber,
      required this.orderDate,
      required this.orderType,
      required this.orderStatus,
      required this.orderTotal,
      required this.shippingAddress})
      : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


