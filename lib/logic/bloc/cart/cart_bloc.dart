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
  final _itemId = BehaviorSubject<int>();
  final _quantity = BehaviorSubject<int>();
  final _itemCount = BehaviorSubject<int>();

  Stream<int> get itemCount => _itemCount.stream;
  Function(int) get updateItemCount => _itemCount.sink.add;

  Stream<int> get item => _itemId.stream;
  Function(int) get addItem => _itemId.sink.add;

  Stream<int> get quantity => _quantity.stream;
  Function(int) get selectedQuantity => _quantity.sink.add;

  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AddToCart>(
      (event, emit) {
        _cartRepo.addToCart(_itemId.value, _quantity.value);
        print('Add To Cart Event Fired');
        print('quantity: ' + _quantity.value.toString());
        _itemCount.hasValue
            ? updateItemCount(_itemCount.value + _quantity.value)
            : updateItemCount(_quantity.value);
        print(_itemCount.value.toString());
      },
    );
    on<RemoveFromCart>(
      (event, emit) {
        _cartRepo.removeFromCart(_itemId.value, _quantity.value);
        updateItemCount(_itemCount.value - _quantity.value);
      },
    );
    on<UpdateItemCount>((event, emit) {
      updateItemCount(_itemCount.value);
    });
  }
}

class UpdateItemCount extends CartEvent {}
