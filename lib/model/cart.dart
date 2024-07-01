import 'dart:convert';

import 'package:hive/hive.dart';

class CartModel extends HiveObject {
  final String user;
  final String productName;
  final String imageUrl;
  final int quantity;
  final double price;
  final String description;

  CartModel({
    required this.user,
    required this.productName,
    required this.imageUrl,
    required this.quantity,
    required this.price,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'productName': productName,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'price': price,
      'description': description,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(

      user: map['user'] ?? '',
      productName: map['productName'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      quantity: map['quantity'] ?? 0,
      price: map['price'] ?? 0.0,
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source));

  CartModel copyWith({
    String? user,
    String? productName,
    String? imageUrl,
    String? quantity,
    int? price,
    String? description
  }) {
    return CartModel(
      user: user ?? this.user,
      productName: productName ?? this.productName,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: int.parse(quantity!) ?? this.quantity,
      price: price!.toDouble() ?? this.price,
      description: description ?? this.description
    );
  }
}
