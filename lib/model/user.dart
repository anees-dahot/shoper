import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:shoper/model/cart.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject{
  @HiveField(0)
   String id;
  @HiveField(1)
   String name;
  @HiveField(2)
   String email;
  @HiveField(3)
   String password;
  @HiveField(4)
   String address;
  @HiveField(5)
   String type;
  @HiveField(6)
   String token;
  @HiveField(7)
   List<CartModel?>? cartItems;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.type,
    required this.token,
     this.cartItems
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
      'cartItems': cartItems,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      cartItems: map['cartItems'] ?? [],
      
    );
  }

  String toJson() => json.encode(toMap());

  
}