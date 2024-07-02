import 'dart:convert';

import 'package:hive/hive.dart';

class CartModel extends HiveObject {
  final String user;
  final String productName;
  final String productId;
  final String imageUrl;
  final int quantity;
   double price;
  final String description;

  CartModel({
    required this.user,
    required this.productName,
    required this.productId,
    required this.imageUrl,
    required this.quantity,
    required this.price,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'productName': productName,
      'productId': productId,
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
      productId: map['productId'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      quantity: map['quantity'] ?? 0,
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source));

  CartModel copyWith({
    String? user,
    String? productName,
    String? productId,
    String? imageUrl,
    int? quantity,
    double? price,
    String? description
  }) {
    return CartModel(
      user: user ?? this.user,
      productName: productName ?? this.productName,
      productId: productId ?? this.productId,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      price: price!.toDouble() ?? this.price,
      description: description ?? this.description
    );
  }
}
