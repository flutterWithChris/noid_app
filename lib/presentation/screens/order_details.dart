import 'dart:async';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animarker/core/ripple_marker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:maps_curved_line/maps_curved_line.dart';
import 'package:noid_app/data/providers/location_service.dart';
import 'package:noid_app/logic/bloc/order/order_bloc.dart';
import 'package:noid_app/presentation/widgets/bottom_nav_bar.dart';
import 'package:noid_app/presentation/widgets/main_app_bar.dart';
import 'package:noid_app/presentation/widgets/order_line_item.dart';
import 'package:woocommerce/models/order.dart';
import 'package:avatar_glow/avatar_glow.dart';

class OrderDetails extends StatefulWidget {
  final WooOrder order;

  const OrderDetails({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor? finishIcon;
  BitmapDescriptor? clearIcon;
  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(32, 32)),
            'lib/assets/finish_icon.png')
        .then((value) => finishIcon = value);
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(32, 32)),
            'lib/assets/clear_icon.png')
        .then((value) => clearIcon = value);
    BlocProvider.of<OrderBloc>(context).setOrder(widget.order);
    BlocProvider.of<OrderBloc>(context).add(ViewOrder());
  }

  var dateFormat = DateFormat('yyyy-MM-ddZHH:nn:ss');

  final Set<Marker> _markers = Set<Marker>();
  final Set<Marker> _destinationMarker = Set<Marker>();
  final Set<Polyline> _polylines = Set();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Set<Polygon> _polygons = Set<Polygon>();
  List<LatLng> polyLatLangs = <LatLng>[];

  final LatLng noid = const LatLng(40.9449734, -72.8204528);
  late Future<LatLng> dest;

  final CameraPosition _noid = const CameraPosition(
    target: LatLng(40.9449734, -72.8204528),
    zoom: 11.0,
  );

  Future<LatLng> _getDestination() async {
    /*   Map<String, dynamic> place = await LocationService().getPlace(
        widget.order.shipping.city + ', ' + widget.order.shipping.state);*/
    Map<String, dynamic> place = await LocationService().getPlace(
        widget.order.shipping.address1 +
            ', ' +
            widget.order.shipping.city +
            ', ' +
            widget.order.shipping.state);
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];
    LatLng destination = LatLng(lat, lng);
    return destination;
  }

  void _drawMarkers() async {
    var controller = await _controller.future;

    LatLng dest = await _getDestination();
    int pointListCount = MapsCurvedLines.getPointsOnCurve(noid, dest).length;
    LatLng centerPoint = MapsCurvedLines.getPointsOnCurve(noid, dest)
        .elementAt(pointListCount ~/ 2);
    setState(() {
      _polylines.add(Polyline(
        polylineId: PolylineId("line 1"),
        visible: true,
        width: 3,
        //latlng is List<LatLng>
        points: MapsCurvedLines.getPointsOnCurve(
            noid, dest), // Invoke lib to get curved line points
        color: Colors.lightBlueAccent,
      ));
      _markers.add(
        Marker(
          anchor: const Offset(0.0, 0.5),
          //rotation: -40.0,
          markerId: const MarkerId('destMarker'),
          position: dest,
          icon: finishIcon!,
          //infoWindow: const InfoWindow(title: 'On The Way...'),
        ),
      );
      _markers.add(
        Marker(
          anchor: const Offset(0.5, -0.2),
          //rotation: -40.0,
          markerId: const MarkerId('centerMarker'),
          position: centerPoint,
          icon: clearIcon!,
          infoWindow: const InfoWindow(title: 'Order En Route!'),
        ),
      );
      _markers.add(
        Marker(
            markerId: const MarkerId('noid'),
            position: noid,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
            infoWindow: const InfoWindow(title: 'Our Store!')),
      );

      _centerCamera(noid, dest);
    });
    await Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        controller.showMarkerInfoWindow(const MarkerId('centerMarker'));
      });
    });
  }

  void _drawProcessingMarkers() async {
    var controller = await _controller.future;

    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('noid'),
          position: noid,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: const InfoWindow(title: 'Preparing Your Order!'),
        ),
      );

      // Center Camera
      controller.animateCamera(CameraUpdate.newLatLngZoom(noid, 9.0));
    });
    await Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        controller.showMarkerInfoWindow(const MarkerId('noid'));
      });
    });
  }

  void _drawCompletedMarker() async {
    var controller = await _controller.future;
    LatLng dest = await _getDestination();

    setState(() {
      _markers.add(
        Marker(
            anchor: const Offset(0.0, 0.0),
            markerId: const MarkerId('destMarker'),
            position: dest,
            icon: finishIcon!,
            infoWindow: const InfoWindow(title: 'Order Delivered!')),
      );

      // Center Camera
      controller.animateCamera(CameraUpdate.newLatLngZoom(dest, 13.0));
    });
    await Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        controller.showMarkerInfoWindow(const MarkerId('destMarker'));
      });
    });
  }

  void _setDestinationMarker(LatLng destination) {
    setState(() {
      markers.addAll({});
    });
  }

  Future<void> _centerCamera(LatLng noid, LatLng dest) async {
    var center = computeCentroid([noid, dest]);
    LatLngBounds bounds = LatLngBounds(southwest: dest, northeast: noid);

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50.0));

    await Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        controller.showMarkerInfoWindow(const MarkerId('destMarker'));
      });
    });
  }

  LatLng computeCentroid(Iterable<LatLng> points) {
    double latitude = 0;
    double longitude = 0;
    int n = points.length;

    for (LatLng point in points) {
      latitude += point.latitude;
      longitude += point.longitude;
    }

    return LatLng(latitude / n, longitude / n);
  }

  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: Implement Flutter_Animarker for status updates on polyline
    WooOrder _order = widget.order;
    List<LineItems> orderItems = [];

    getOrderItems(WooOrder order) {
      WooOrder _order = order;
      for (var i = 0; i < order.lineItems.length; i++) {
        orderItems.add(order.lineItems.elementAt(i));
      }
    }

    getOrderItems(_order);
    print(orderItems.length.toString() + " items");

    String formatDate() {
      var orderDate = DateTime.parse(_order.dateCreated);
      var dateFormat =
          DateFormat('MM/dd/yyyy' + ' - hh:mm a').format(orderDate);
      return dateFormat;
    }

    int _polygonIdCounter = 1;

    // * Set Order in Bloc

    return Scaffold(
      appBar: const MainAppBar(),
      bottomNavigationBar: const BottomNavBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView(shrinkWrap: true,
                // Order Top Details
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order #' + _order.number,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 28),
                        ),
                        Text(
                          formatDate(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tight(Size.fromHeight(72)),
                      child: OrderStatusStepper(currentStep: _currentStep),
                    ),
                  ),
                  SizedBox(
                    height: 250,
                    child: BlocConsumer<OrderBloc, OrderState>(
                      listener: (context, state) {
                        if (state is OrderProcessing) {
                          _drawProcessingMarkers();
                          _currentStep = 0;
                        }
                        if (state is OrderShipped) {
                          _drawMarkers();
                          _currentStep = 1;
                        }
                        if (state is OrderCompleted) {
                          _drawCompletedMarker();
                          _currentStep = 2;
                        }
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        if (state is OrderProcessing) {
                          return IgnorePointer(
                            child: OrderProcessingMap(
                                noid: _noid,
                                markers: _markers,
                                controller: _controller),
                          );
                        }
                        if (state is OrderShipped) {
                          return IgnorePointer(
                            child: OrderShippedMap(
                                noid: _noid,
                                markers: _markers,
                                polygons: _polygons,
                                polylines: _polylines,
                                controller: _controller),
                          );
                        }
                        if (state is OrderCompleted) {
                          return IgnorePointer(
                            child: OrderCompletedMap(
                                noid: _noid,
                                markers: _markers,
                                controller: _controller),
                          );
                        } else {
                          return const Center(
                            child: Text('Error Loading Order!'),
                          );
                        }
                      },
                    ),
                  ),
                  // Item List
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(20, 15, 0, 5),
                    child: const Text(
                      'Order Summary',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  // ? Explore Table Widget for list items
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
                  Divider(),
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

class OrderCompletedMap extends StatelessWidget {
  const OrderCompletedMap({
    Key? key,
    required CameraPosition noid,
    required Set<Marker> markers,
    required Completer<GoogleMapController> controller,
  })  : _noid = noid,
        _markers = markers,
        _controller = controller,
        super(key: key);

  final CameraPosition _noid;
  final Set<Marker> _markers;
  final Completer<GoogleMapController> _controller;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        zoomControlsEnabled: false,
        initialCameraPosition: _noid,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) async {
          _controller.complete(controller);
        });
  }
}

class OrderShippedMap extends StatelessWidget {
  const OrderShippedMap({
    Key? key,
    required CameraPosition noid,
    required Set<Marker> markers,
    required Set<Polygon> polygons,
    required Set<Polyline> polylines,
    required Completer<GoogleMapController> controller,
  })  : _noid = noid,
        _markers = markers,
        _polygons = polygons,
        _polylines = polylines,
        _controller = controller,
        super(key: key);

  final CameraPosition _noid;
  final Set<Marker> _markers;
  final Set<Polygon> _polygons;
  final Set<Polyline> _polylines;
  final Completer<GoogleMapController> _controller;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        zoomControlsEnabled: false,
        initialCameraPosition: _noid,
        markers: _markers,
        polygons: _polygons,
        polylines: _polylines,
        onMapCreated: (GoogleMapController controller) async {
          _controller.complete(controller);
        });
  }
}

class OrderProcessingMap extends StatelessWidget {
  const OrderProcessingMap({
    Key? key,
    required CameraPosition noid,
    required Set<Marker> markers,
    required Completer<GoogleMapController> controller,
  })  : _noid = noid,
        _markers = markers,
        _controller = controller,
        super(key: key);

  final CameraPosition _noid;
  final Set<Marker> _markers;
  final Completer<GoogleMapController> _controller;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        zoomControlsEnabled: false,
        initialCameraPosition: _noid,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) async {
          _controller.complete(controller);
        });
  }
}

class OrderStatusStepper extends StatelessWidget {
  const OrderStatusStepper({
    Key? key,
    required int currentStep,
  })  : _currentStep = currentStep,
        super(key: key);

  final int _currentStep;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: Stepper(
        currentStep: _currentStep,
        elevation: 0,
        type: StepperType.horizontal,
        steps: [
          Step(
            title: Text('Processing'),
            content: Text(''),
            isActive: _currentStep >= 0,
          ),
          Step(
            title: Text('Shipped'),
            content: Text('Your order is on the way!!'),
            isActive: _currentStep >= 1,
          ),
          Step(
            title: Text('Completed'),
            content: Text('All done!'),
            isActive: _currentStep >= 2,
          ),
        ],
      ),
      data: ThemeData(
        colorScheme:
            Theme.of(context).colorScheme.copyWith(primary: Colors.lightGreen),
      ),
    );
  }
}
