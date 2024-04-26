import 'dart:convert';

class ProductModel {
  final String? id;
  final String? senderId;
  final String name;
  final double price;
  final String description;
  final int quantity;
  final String category;
  final List<String> images;

  ProductModel({
    this.id,
    this.senderId,
    required this.name,
    required this.price,
    required this.description,
    required this.quantity,
    required this.category,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'name': name,
      'price': price,
      'description': description,
      'quantity': quantity,
      'category': category,
      'images': images,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['_id'] ?? '',
      senderId: map['senderId'] ?? '',
      name: map['name'] ?? '',
      price: map['price']?.toDouble() ?? 0.0, // Convert price to double
      description: map['description'] ?? '',
      quantity: map['quantity'] ?? 0, // Default quantity to 0
      category: map['category'] ?? '',
      images: List<String>.from(map['images'] ?? []), // Convert images to list
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  ProductModel copyWith({
    String? id,
    String? senderId,
    String? name,
    double? price,
    String? description,
    int? quantity,
    String? category,
    List<String>? images,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      images: images ?? this.images,
    );
  }
}
