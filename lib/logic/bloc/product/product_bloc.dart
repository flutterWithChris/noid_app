import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:noid_app/data/repository/product_repo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:woocommerce/models/products.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo _productRepo = ProductRepo();

  final _products = BehaviorSubject<List<WooProduct>>();
  Stream<List<WooProduct>> get getProducts => _products.stream;

  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoadProducts>((event, emit) {
      _getAllProducts(_productRepo);
    });
  }
}

_getAllProducts(ProductRepo productRepo) async {
  var products = await productRepo.getProducts();
  return products;
}
