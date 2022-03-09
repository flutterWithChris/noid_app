import 'package:flutter/material.dart';
import 'package:noid_app/data/Model/current_user.dart';
import 'package:noid_app/data/Model/woo_controller.dart';
import 'package:noid_app/presentation/widgets/bottom_nav_bar.dart';
import 'package:noid_app/presentation/widgets/main_app_bar.dart';
import 'package:noid_app/presentation/widgets/order_card.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:intl/intl.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final WooCommerce _wooController = WooRepo().wooController;
  WooCustomer? user = CurrentUser.instance;
  List<WooOrder> allOrders = [];
  int count = 1;

  Future<List<WooOrder>> _getMyOrders() async {
    var orders = await _wooController.getOrders(customer: user!.id);
    List<WooOrder> myOrders = [];
    for (var o in orders) {
      WooOrder order = o;
      myOrders.add(o);
    }
    return myOrders;
  }

  getOrders() async {
    print(user?.id);
    allOrders = await _wooController.getOrders(customer: user!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      bottomNavigationBar: const BottomNavBar(),
      body: Column(
        children: [
          const SizedBox(
            child: Padding(
              padding: EdgeInsets.all(15.0),
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
                return const IsLoading();
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

class IsLoading extends StatelessWidget {
  const IsLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
