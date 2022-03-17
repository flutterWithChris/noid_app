part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class AddToCart extends CartEvent {}

class RemoveFromCart extends CartEvent {}

class UpdateCart extends CartEvent {}

class DeleteCart extends CartEvent {}
