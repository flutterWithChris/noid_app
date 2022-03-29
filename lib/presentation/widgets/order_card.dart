import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:noid_app/logic/bloc/order/order_bloc.dart';
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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        elevation: 1.5,
        child: BlocProvider(
          create: (context) => OrderBloc(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: ListTile(
              visualDensity: VisualDensity.compact,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              leading: BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  BlocProvider.of<OrderBloc>(context).setOrder(widget.order);
                  BlocProvider.of<OrderBloc>(context).add(ViewOrder());
                  if (state is OrderProcessing) {
                    return const Icon(
                      Icons.hourglass_bottom,
                      color: Colors.black45,
                    );
                  }
                  if (state is OrderShipped) {
                    return const Icon(
                      Icons.local_shipping,
                      color: Colors.lightBlue,
                    );
                  }

                  if (state is OrderCompleted) {
                    return const Icon(
                      Icons.check_circle,
                      color: Colors.lightGreen,
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
              minLeadingWidth: 35,
              title: Text('Order #' + widget.order.number,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                  StringUtils.capitalize(widget.order.status) +
                      '\n' +
                      '\$' +
                      widget.order.total,
                  style: const TextStyle(height: 1.618)),
              tileColor: Colors.white,
              trailing: const Icon(Icons.arrow_forward_rounded),
              contentPadding: const EdgeInsets.all(25),
              onTap: () => {
                Get.to(
                  () => BlocProvider(
                    create: (context) => OrderBloc(),
                    child: OrderDetails(order: widget.order),
                  ),
                ),
              },
            ),
          ),
        ),
      ),
    );
  }
}
