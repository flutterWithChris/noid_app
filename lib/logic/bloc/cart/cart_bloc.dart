import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:noid_app/data/repository/cart_repo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:woocommerce/models/cart_item.dart';
import 'package:woocommerce/models/products.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepo _cartRepo = CartRepo();
  final _item = BehaviorSubject<WooProduct>();
  final _quantity = BehaviorSubject<int>();

  Stream<WooProduct> get item => _item.stream;
  Function(WooProduct) get addItem => _item.sink.add;

  Stream<int> get quantity => _quantity.stream;
  Function(int) get selectedQuantity => _quantity.sink.add;

  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AddToCart>(
      (event, emit) {
        _cartRepo.addToCart(
            _item.value.id.toString(), _quantity.value.toString());
        print(_item.value.name + " added to cart!**");
      },
    );
    on<RemoveFromCart>(
      (event, emit) {
        _cartRepo.removeFromCart(_item.value.id.toString());
      },
    );
  }
}
