part of 'product_bloc.dart';


@immutable
abstract class ProductEvent {}

class ViewProduct extends ProductEvent{}

class LoadProducts extends ProductEvent{}

