import 'package:flutter/material.dart';
import 'package:noid_app/Model/order.dart';
import 'package:noid_app/View/main.dart';
import 'package:noid_app/routes/route.dart';
import 'package:noid_app/view/current_order.dart';
import 'package:noid_app/view/order_details.dart';
import 'package:noid_app/view/order_info.dart';

class OrderCard extends StatefulWidget {
  Order thisOrder;

  OrderCard({
    Key? key,
    required this.thisOrder,
  }) : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    //print(OrderInfo.of(context)!.currentOrder.orderStatus);
    // Order Card
    return ListTile(
        leading: Icon(Icons.check_circle),
        minLeadingWidth: 35,
        title: Text('Order #' + widget.thisOrder.orderNumber.toString(),
            style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
            widget.thisOrder.orderDate +
                '\n' +
                '\$' +
                widget.thisOrder.orderTotal.toString(),
            style: TextStyle(height: 1.618)),
        tileColor: Colors.white,
        trailing: Icon(Icons.arrow_forward_rounded),
        contentPadding: EdgeInsets.all(25),
        onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderDetails(order: widget.thisOrder),
                ),
              )
            });
  }
}
