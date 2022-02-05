import 'package:flutter/material.dart';
import 'package:noid_app/view/order_card.dart';

class CurrentOrder extends StatefulWidget {
  OrderCard currentCard;

  CurrentOrder({Key? key, required this.currentCard}) : super(key: key);

  @override
  State<CurrentOrder> createState() => _CurrentOrderState();
}

class _CurrentOrderState extends State<CurrentOrder> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
