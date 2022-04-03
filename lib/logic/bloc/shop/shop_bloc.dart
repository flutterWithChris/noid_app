import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:noid_app/data/repository/product_repo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:woocommerce/models/products.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ProductRepo _productRepo = ProductRepo();

  final _products = BehaviorSubject<List<WooProduct>>();
  Stream<List<WooProduct>> get viewProducts => _products.stream;
  Function(List<WooProduct>) get loadProducts => _products.sink.add;

  ShopBloc() : super(ShopInitial()) {
    on<ShopEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoadProducts>((event, emit) async {
      emit(LoadingProducts());
      var products = await _getAllProducts(_productRepo);
      loadProducts(products);
      emit(ProductsLoaded());
    });
  }
}

Future<List<WooProduct>> _getAllProducts(ProductRepo productRepo) async {
  var _products = await productRepo.getProducts();
  return _products;
}
