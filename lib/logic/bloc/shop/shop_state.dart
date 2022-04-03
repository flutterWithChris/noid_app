part of 'shop_bloc.dart';

@immutable
abstract class ShopState {}

class ShopInitial extends ShopState {}

class LoadingProducts extends ShopState{}

class ProductsLoaded extends ShopState{}
