import 'package:flutter/material.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 136,
        child: Card(
          child: Column(
            children: [
              const ListTile(
                leading: Icon(Icons.check_circle),
                title: Text('Order #1234'),
                subtitle: Text('Processing, ships soon!'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 25, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    TextButton(onPressed: null, child: Text('Order Status')),
                    TextButton(onPressed: null, child: Text('Edit Order')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
