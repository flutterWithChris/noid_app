import 'package:flutter/material.dart';
import 'package:noid_app/Controller/woo_controller.dart';
import 'package:noid_app/routes/route.dart';
import 'package:noid_app/view/bottom_nav_bar.dart';
import 'package:noid_app/view/main_app_bar.dart';
import 'package:noid_app/view/order_card.dart';
import 'package:noid_app/view/order_cards.dart';
import 'package:woocommerce/woocommerce.dart';
import 'globals.dart' as globals;

class MyOrders extends StatefulWidget {
  MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  WooCommerce _wooController = wooController;
  WooCustomer user = globals.currentUser;
  List<WooOrder> allOrders = [];
  int count = 1;

  Future<List<WooOrder>> _getMyOrders() async {
    var orders = await _wooController.getOrders(customer: user.id);
    List<WooOrder> myOrders = [];
    for (var o in orders) {
      WooOrder order = o;
      myOrders.add(o);
    }
    return myOrders;
  }

  getOrders() async {
    print(user.id);
    allOrders = await _wooController.getOrders(customer: user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      bottomNavigationBar: BottomNavBar(),
      body: Column(
        children: [
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "My Orders",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          FutureBuilder(
            future: _getMyOrders(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return isLoading();
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    //WooOrder order = allOrders[index];

                    final order = snapshot.data[index];
                    return OrderCard(order: order);
                  },
                );

                /*   return Container(
                      child: Text("Nope"),
                    );*/

              }
            },
          ),
        ],
      ),
    );
  }
}

class isLoading extends StatelessWidget {
  const isLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
