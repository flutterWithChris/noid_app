part of 'order_bloc.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderPlaced extends OrderState {}

class OrderFailed extends OrderState {}

class OrderProcessing extends OrderState {}

class OrderShipped extends OrderState {}

class OrderCompleted extends OrderState {}

class OrderCancelled extends OrderState {}

class OrderRefunded extends OrderState {}

class OrderNotLoaded extends OrderState {}
