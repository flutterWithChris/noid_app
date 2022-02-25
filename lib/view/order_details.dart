import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noid_app/Model/order.dart';
import 'package:noid_app/view/bottom_nav_bar.dart';
import 'package:noid_app/view/main_app_bar.dart';
import 'package:noid_app/view/order_info.dart';
import 'package:woocommerce/woocommerce.dart';

class OrderDetails extends StatefulWidget {
  final WooOrder order;

  const OrderDetails({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var dateFormat = DateFormat('yyyy-MM-ddZHH:nn:ss');
  
 formatDate(DateTime dateTime){
   return formatDate(dateTime, dateFormat, ])
 }

  var outputFormt = DateFormat('MM/dd/yyyy hh:mm a')
  @override
  Widget build(BuildContext context) {
    WooOrder _order = widget.order;
    List<Step> stepList() => [
          const Step(title: Text('Order Received'), content: Text('Test')),
          const Step(title: Text('Order Shipped'), content: Text('Test')),
          const Step(title: Text('Order Delivered'), content: Text('Test')),
        ];

    return Scaffold(
      appBar: const MainAppBar(),
      bottomNavigationBar: const BottomNavBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView(shrinkWrap: true,
                // Order Top Details
                children: [
                  SizedBox(
                    child: Image.network(
                        'https://media.wired.com/photos/5a6a61938c669c70314b300d/master/pass/Google-Map-US_10.jpg'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                    child: ListTile(
                      title: Text(
                        'Order #' + _order.number,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      subtitle: Row(
                        children: [
                          const Icon(
                            Icons.circle,
                            color: Colors.lightGreen,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _order.status.toUpperCase(),
                              textAlign: TextAlign.left,
                              style: const TextStyle(height: 1.5),
                            ),
                          ),
                        ],
                      ),
                      trailing: Text(
                        _order.dateCompleted,
                      ),
                    ),
                  ),
                  _order.status == "complete"
                      ? Row(
                          children: [
                            Expanded(
                              child: FractionallySizedBox(
                                widthFactor: .9,
                                child: OutlinedButton(
                                  child: const Text('Edit Order'),
                                  onPressed: () => null,
                                ),
                              ),
                            ),
                            Expanded(
                              child: FractionallySizedBox(
                                widthFactor: .9,
                                child: ElevatedButton(
                                  child: const Text('Cancel Order'),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red),
                                  onPressed: () => null,
                                ),
                              ),
                            ),
                          ],
                        )
                      : FractionallySizedBox(
                          widthFactor: .80,
                          child: ElevatedButton(
                              onPressed: () => print("Reorder"),
                              child: const Text("Reorder")),
                        ),
                  // Item List
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(8),
                    child: const Text(
                      'Items',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    child: ListView(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.offline_bolt),
                          title: Text(
                            _order.lineItems.first.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              "ID: " + _order.lineItems.first.id.toString()),
                          trailing: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'x' +
                                      _order.lineItems.first.quantity
                                          .toString(),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              Text('\$' + _order.lineItems.first.price)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  // Shipping/Billing Info
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FractionallySizedBox(
                            widthFactor: 0.5,
                            child: Column(
                              children: [
                                const Text(
                                  'Billed To:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, height: 2.0),
                                ),
                                Text(_order.billing.firstName +
                                    " " +
                                    _order.billing.lastName),
                                Text(_order.billing.address1),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        color: Colors.black,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FractionallySizedBox(
                            widthFactor: 0.5,
                            child: Column(
                              children: [
                                const Text(
                                  'Shipped To:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, height: 2.0),
                                ),
                                Text(_order.shipping.firstName +
                                    " " +
                                    _order.shipping.lastName),
                                Text(_order.shipping.address1 +
                                    " " +
                                    _order.shipping.city),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  SizedBox(
                    child: Expanded(
                      child: Stepper(
                        steps: stepList(),
                      ),
                    ),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}
