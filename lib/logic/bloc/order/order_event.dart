part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class PlaceOrder extends OrderEvent {}

class EditOrder extends OrderEvent {}

class CancelOrder extends OrderEvent {}

class ViewOrder extends OrderEvent {}
