import 'package:flutter/material.dart';
import 'package:noid_app/Model/order.dart';
import 'package:noid_app/view/bottom_nav_bar.dart';
import 'package:noid_app/view/main_app_bar.dart';
import 'package:noid_app/view/order_info.dart';
import 'package:woocommerce/woocommerce.dart';

class OrderDetails extends StatefulWidget {
  final WooOrder order;

  OrderDetails({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    WooOrder _order = widget.order;
    List<Step> stepList() => [
          Step(title: Text('Order Received'), content: Text('Test')),
          Step(title: Text('Order Shipped'), content: Text('Test')),
          Step(title: Text('Order Delivered'), content: Text('Test')),
        ];

    return Scaffold(
      appBar: MainAppBar(),
      bottomNavigationBar: BottomNavBar(),
      body: Column(
        children: [
          SizedBox(
            child: Image.network(
                'https://media.wired.com/photos/5a6a61938c669c70314b300d/master/pass/Google-Map-US_10.jpg'),
          ),
          Expanded(
            child: ListView(shrinkWrap: true,

                // Order Top Details
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                    child: ListTile(
                      title: Text(
                        'Order #' + _order.number,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      subtitle: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: Colors.lightGreen,
                            size: 12,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              _order.status.toUpperCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(height: 1.5),
                            ),
                          ),
                        ],
                      ),
                      trailing: Text(
                        _order.dateCompleted,
                      ),
                    ),
                  ),
                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: FractionallySizedBox(
                          widthFactor: .9,
                          child: OutlinedButton(
                            child: Text('Edit Order'),
                            onPressed: () => null,
                          ),
                        ),
                      ),
                      Expanded(
                        child: FractionallySizedBox(
                          widthFactor: .9,
                          child: ElevatedButton(
                            child: Text('Cancel Order'),
                            style:
                                ElevatedButton.styleFrom(primary: Colors.red),
                            onPressed: () => null,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Item List
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(8),
                    child: Text(
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
                          leading: Icon(Icons.offline_bolt),
                          title: Text(
                            'Lazarus Naturals CBD Oil',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('3000mg | Chocolate Mint 2 Oz.'),
                          trailing: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'x2',
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              Text('\$70.00')
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
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
                                Text(
                                  'Billed To:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, height: 2.0),
                                ),
                                Text('Ronald Zukas'),
                                Text(_order.billing.address1),
                              ],
                            ),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.black,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FractionallySizedBox(
                            widthFactor: 0.5,
                            child: Column(
                              children: [
                                Text(
                                  'Shipped To:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, height: 2.0),
                                ),
                                Text('Ronald Zukas'),
                                Text(_order.shipping.address1),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
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
