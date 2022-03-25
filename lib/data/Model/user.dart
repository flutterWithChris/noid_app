import 'package:equatable/equatable.dart';
import 'package:noid_app/data/repository/user_storage.dart';

class User extends Equatable {
  int? userId;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? shippingAddress;
  String? billingAddress;
  String? token;

  set setToken(_token) {
    UserStorage.setUserToken(_token);
  }

  get getUserId => this.userId;

  void setUserId(userId) {
    this.userId = userId;
    UserStorage.setUserId(userId);
  }

  get getUsername => this.username;

  void setUsername(username) {
    this.username = username;
    UserStorage.setUsername(username);
  }

  get getFirstName => this.firstName;

  void setFirstName(firstName) {
    this.firstName = firstName;
    UserStorage.setFirstName(firstName);
  }

  get getLastName => this.lastName;

  void setLastName(lastName) {
    this.lastName = lastName;
    UserStorage.setLastName(lastName);
  }

  get getEmail => this.email;

  void setEmail(email) {
    this.email = email;
    UserStorage.setEmail(email);
  }

  get getShippingAddress => this.shippingAddress;

  void setShippingAddress(shippingAddress) =>
      this.shippingAddress = shippingAddress;

  get getBillingAddress => this.billingAddress;

  void setBillingAddress(billingAddress) =>
      this.billingAddress = billingAddress;
  User({
    this.userId,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.shippingAddress,
    this.billingAddress,
    this.token,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [userId];

  static var empty = User();
}
