import 'package:equatable/equatable.dart';
import 'package:noid_app/data/repository/user_storage.dart';

class User extends Equatable {
  String? userId;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? shippingAddress;
  String? billingAddress;
  String? _token;

  set setToken(_token) {
    UserStorage.setUserToken(_token);
  }

  get getUserId => this.userId;

  set setUserId(userId) {
    this.userId = userId;
    UserStorage.setUserId(userId);
  }

  get getUsername => this.username;

  set setUsername(username) {
    this.username = username;
    UserStorage.setUsername(username);
  }

  get getFirstName => this.firstName;

  set setFirstName(firstName) {
    this.firstName = firstName;
    UserStorage.setFirstName(firstName);
  }

  get getLastName => this.lastName;

  set setLastName(lastName) {
    this.lastName = lastName;
    UserStorage.setLastName(lastName);
  }

  get getEmail => this.email;

  set setEmail(email) {
    this.email = email;
    UserStorage.setEmail(email);
  }

  get getShippingAddress => this.shippingAddress;

  set setShippingAddress(shippingAddress) =>
      this.shippingAddress = shippingAddress;

  get getBillingAddress => this.billingAddress;

  set setBillingAddress(billingAddress) => this.billingAddress = billingAddress;
  User({
    this.userId,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.shippingAddress,
    this.billingAddress,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [userId];

  static var empty = User();
}
