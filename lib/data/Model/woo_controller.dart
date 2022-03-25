import 'package:woocommerce/woocommerce.dart';

class WooRepo {
  final WooCommerce wooController = WooCommerce(
    baseUrl: 'https://wordpress-513850-2524483.cloudwaysapps.com/',
    consumerKey: 'ck_c23cf1d85ea1816b69985997a551c4bdd3c4354c',
    consumerSecret: 'cs_32781d637727532a5ce9f8f7250cace119303155',
    /*  consumerKey: 'ck_f30d980143df05e9ade0ada6351657b3a507eeb1',
    consumerSecret: 'cs_766a5ac05864843a237b2717904f0a15909322b2',*/
  );

  get getWooController => wooController;
}
