import 'package:woocommerce/woocommerce.dart';

class WooRepo {
  final WooCommerce wooController = WooCommerce(
    baseUrl: 'https://noidbotanicals.com',
    consumerKey: 'ck_f30d980143df05e9ade0ada6351657b3a507eeb1',
    consumerSecret: 'cs_766a5ac05864843a237b2717904f0a15909322b2',
  );

  get getWooController => wooController;
}
