import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:woocommerce/models/order.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final _order = BehaviorSubject<WooOrder>();

  Stream<WooOrder> get order => _order.stream;
  Function(WooOrder) get setOrder => _order.sink.add;

  OrderBloc() : super(OrderInitial()) {
    on<OrderEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ViewOrder>(
      (event, emit) {
        emit(OrderLoading());
        final _currentOrder = _order.value;
        final status = _currentOrder.status;
        if (status == 'processing') {
          emit(OrderProcessing());
        }
        if (status == 'shipped') {
          emit(OrderShipped());
        }
        if (status == 'completed') {
          emit(OrderCompleted());
        }
      },
    );
  }
  void dispose() {
    _order.close();
  }
}
