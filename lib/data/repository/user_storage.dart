import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:noid_app/presentation/screens/shipping_info.dart';
import 'package:woocommerce/models/user.dart';

class UserStorage {
  static final _storage = FlutterSecureStorage();

  static const _userId = '000';
  static const _username = 'username';
  static const _firstName = 'firstname';
  static const _lastName = 'lastName';
  static const _email = 'email';
  static const _userToken = 'userToken';
  static const _billingInfo = 'billingInfo';
  static const _shippingInfo = 'shippingInfo';

  static Future setBillingInfo(String billingInfo) async =>
      await _storage.write(key: _billingInfo, value: billingInfo);

  static Future<String?> getBillingInfo() async =>
      await _storage.read(key: _billingInfo);

  static Future setShippingInfo(String shippingInfo) async =>
      await _storage.write(key: _shippingInfo, value: shippingInfo);

  static Future<String?> getShippingInfo() async =>
      await _storage.read(key: _shippingInfo);

  static Future setUserId(int userId) async =>
      await _storage.write(key: _userId, value: userId.toString());

  static Future<String?> getUserId() async => await _storage.read(key: _userId);

  static Future setUsername(String username) async =>
      await _storage.write(key: _username, value: username);

  static Future<String?> getUsername() async =>
      await _storage.read(key: _username);

  static Future setFirstName(String firstName) async =>
      await _storage.write(key: _firstName, value: firstName);

  static Future<String?> getFirstName() async =>
      await _storage.read(key: _firstName);

  static Future setLastName(String lastName) async =>
      await _storage.write(key: _lastName, value: lastName);

  static Future<String?> getLastName() async =>
      await _storage.read(key: _lastName);

  static Future setEmail(String email) async =>
      await _storage.write(key: _email, value: email);

  static Future<String?> getEmail() async => await _storage.read(key: _email);

  static Future setUserToken(String userToken) async =>
      await _storage.write(key: _userToken, value: userToken);

  static Future<String?> getUserToken() async =>
      await _storage.read(key: _userToken);
}
