import 'package:flutter/material.dart';
import 'package:noid_app/presentation/screens/order_details.dart';
import 'package:woocommerce/models/order.dart';

class OrderCard extends StatefulWidget {
  final WooOrder order;

  const OrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    //print(OrderInfo.of(context)!.currentOrder.orderStatus);
    // Order Card
    return Card(
      elevation: 1.5,
      child: ListTile(
          leading: const Icon(Icons.check_circle),
          minLeadingWidth: 35,
          title: Text('Order #' + widget.order.number,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(widget.order.status + '\n' + '\$' + widget.order.total,
              style: const TextStyle(height: 1.618)),
          tileColor: Colors.white,
          trailing: const Icon(Icons.arrow_forward_rounded),
          contentPadding: const EdgeInsets.all(25),
          onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetails(order: widget.order),
                  ),
                )
              }),
    );
  }
}