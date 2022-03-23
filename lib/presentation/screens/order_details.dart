import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:noid_app/data/providers/location_service.dart';
import 'package:noid_app/presentation/widgets/bottom_nav_bar.dart';
import 'package:noid_app/presentation/widgets/main_app_bar.dart';
import 'package:noid_app/presentation/widgets/order_line_item.dart';
import 'package:woocommerce/models/order.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:basic_utils/basic_utils.dart';

class OrderDetails extends StatefulWidget {
  final WooOrder order;

  const OrderDetails({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  Completer<GoogleMapController> _controller = Completer();

  var dateFormat = DateFormat('yyyy-MM-ddZHH:nn:ss');

  final Set<Marker> _markers = Set<Marker>();
  final Set<Marker> _destinationMarker = Set<Marker>();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Set<Polygon> _polygons = Set<Polygon>();
  List<LatLng> polyLatLangs = <LatLng>[];

  final CameraPosition _noid = CameraPosition(
    target: LatLng(40.9449734, -72.8204528),
    zoom: 11.0,
  );

  Future<LatLng> _drawDestinationMarker() async {
    Map<String, dynamic> place = await LocationService().getPlace('Ridge');
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];
    LatLng destination = LatLng(lat, lng);
    return destination;
  }

  void _setMarker() async {
    LatLng noid = await LatLng(40.9449734, -72.8204528);
    LatLng dest = await _drawDestinationMarker();
    setState(() {
      _polygons.add(Polygon(
        polygonId: PolygonId('shippingLine'),
        points: [noid, dest],
        strokeWidth: 3,
        strokeColor: Colors.white,
      ));
      markers.addAll({
        const MarkerId('noidMarker'): Marker(
            markerId: const MarkerId('noidMarker'),
            position: noid,
            infoWindow: InfoWindow(title: 'Our Store!')),
        const MarkerId('destMarker'): Marker(
            markerId: const MarkerId('destMarker'),
            position: dest,
            infoWindow: InfoWindow(title: 'Destination')),
      });
    });

    /*_markers.add(
      Marker(markerId: const MarkerId('marker'), position: noidPoint),
    );*/
  }

  void _setDestinationMarker(LatLng destination) {
    setState(() {
      markers.addAll({});
    });
  }

  @override
  void initState() {
    super.initState();
    _setMarker();
  }

  @override
  Widget build(BuildContext context) {
    WooOrder _order = widget.order;
    List<LineItems> orderItems = [];

    getOrderItems(WooOrder order) {
      var _order = order;
      for (var i = 0; i < order.lineItems.length; i++) {
        orderItems.add(order.lineItems.elementAt(i));
      }
    }

    getOrderItems(_order);
    print(orderItems.length.toString() + " items");

    String formatDate() {
      var orderDate = DateTime.parse(_order.dateCompleted);
      var dateFormat =
          DateFormat('MM/dd/yyyy' + ' - HH:mm a').format(orderDate);
      return dateFormat;
    }

    int _polygonIdCounter = 1;

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
                    height: 250,
                    child: GoogleMap(
                        scrollGesturesEnabled: false,
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: false,
                        // TODO: Set initial camera to midpoint between noid & dest
                        initialCameraPosition: _noid,
                        markers: Set<Marker>.of(markers.values),
                        polygons: _polygons,
                        myLocationEnabled: true,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        }),
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
                              StringUtils.capitalize(_order.status),
                              textAlign: TextAlign.left,
                              style: const TextStyle(height: 1.5),
                            ),
                          ),
                        ],
                      ),
                      trailing: Column(
                        children: [
                          Text(
                            formatDate(),
                          ),
                        ],
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
                              onPressed: () async {
                                Map<String, dynamic> map =
                                    await LocationService().getPlace('Ridge');
                              },
                              child: const Text("Reorder")),
                        ),
                  // Item List
                  const Divider(),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(20, 10, 0, 5),
                    child: const Text(
                      'Order Summary',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    //height: 300,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: orderItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        LineItems _currentItem =
                            _order.lineItems.elementAt(index);
                        return OrderLineItem(
                            product: _currentItem,
                            quantity: _currentItem.quantity,
                            price: _currentItem.price,
                            subtotal: _currentItem.subtotal);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 17, 15),
                    child: Wrap(
                      spacing: 10,
                      alignment: WrapAlignment.end,
                      direction: Axis.horizontal,
                      children: [
                        //Shipping
                        const Text(
                          'Shipping:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(" \$" + _order.shippingTotal),
                        //Taxes
                        const Text(
                          'Tax:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(" \$" + _order.totalTax),
                        //Total
                        const Text(
                          'Total:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(" \$" + _order.total),
                      ],
                    ),
                  ),
                  const Divider(),
                  // Shipping/Billing Info
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                          child: Text(
                            "Billing & Shipping",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'Billed To:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, height: 2.0),
                                ),
                                Text(
                                  _order.billing.firstName +
                                      " " +
                                      _order.billing.lastName +
                                      "\n" +
                                      _order.billing.address1 +
                                      " " +
                                      "\n" +
                                      _order.billing.city +
                                      ", " +
                                      _order.billing.state +
                                      " " +
                                      _order.billing.postcode,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(height: 1.4),
                                ),
                              ],
                            ),
                            const VerticalDivider(
                              color: Colors.black,
                            ),
                            Column(
                              children: [
                                const Text(
                                  'Shipped To:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, height: 2.0),
                                ),
                                Text(
                                  _order.shipping.firstName +
                                      " " +
                                      _order.shipping.lastName +
                                      "\n" +
                                      _order.shipping.address1 +
                                      " " +
                                      "\n" +
                                      _order.shipping.city +
                                      ", " +
                                      _order.shipping.state +
                                      " " +
                                      _order.shipping.postcode,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(height: 1.4),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                ]),
          ),
        ],
      ),
    );
  }
}
