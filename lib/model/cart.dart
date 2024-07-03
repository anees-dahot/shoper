import 'dart:convert';

import 'package:hive/hive.dart';

class CartModel extends HiveObject {
  final String sellerId;
  final String buyerId;
  final String productName;
  final String productId;
  final String imageUrl;
  final int quantity;
  double price;
  final String description;
  final String? color;
  final int? size;

  CartModel({
    required this.sellerId,
    required this.buyerId,
    required this.productName,
    required this.productId,
    required this.imageUrl,
    required this.quantity,
    required this.price,
    required this.description,
    required this.color,
    required this.size,
  });

  Map<String, dynamic> toMap() {
    return {
      'sellerId': sellerId,
      'buyerId': buyerId,
      'productName': productName,
      'productId': productId,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'price': price,
      'description': description,
      'color': color,
      'size': size,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      sellerId: map['sellerId'] ?? '',
      buyerId: map['buyerId'] ?? '',
      productName: map['productName'] ?? '',
      productId: map['productId'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      quantity: map['quantity'] ?? 0,
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      description: map['description'] ?? '',
      color: map['color'] ?? '', // Convert color to list
      size: map['size'] ?? 0, // Convert size to list
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source));

  CartModel copyWith({
    String? sellerId,
    String? buyerId,
    String? productName,
    String? productId,
    String? imageUrl,
    int? quantity,
    double? price,
    String? description,
    String? color,
    int? size,
  }) {
    return CartModel(
      sellerId: sellerId ?? this.sellerId,
      buyerId: buyerId ?? this.buyerId,
      productName: productName ?? this.productName,
      productId: productId ?? this.productId,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      price: price!.toDouble() ?? this.price,
      description: description ?? this.description,
      color: color ?? this.color,
      size: size ?? this.size,
    );
  }
}
