import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:shoper/model/reviews.dart';

part 'product.g.dart';

@HiveType(typeId: 1)
class ProductModel  extends HiveObject {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? senderId;
  @HiveField(2)
  final String? name;
  @HiveField(3)
  final double? price;
  @HiveField(4)
  final int? sale;
  @HiveField(5)
  final String? description;
  @HiveField(6)
  final int? quantity;
  @HiveField(7)
  final String? category;
  @HiveField(8)
  final List<String>? images;
  @HiveField(9)
   List<ReviewsModel>? reviews;
  @HiveField(10)
  final List<String>? colors;
  @HiveField(11)
  final List<int>? sizes;

  ProductModel({
    this.id,
    this.senderId,
     this.name,
     this.price,
     this.sale,
     this.description,
     this.quantity,
     this.category,
     this.images,
    this.reviews, 
     this.colors,
     this.sizes
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'name': name,
      'price': price,
      'sale' : sale,
      'description': description,
      'quantity': quantity,
      'category': category,
      'images': images,
      'reviews': reviews?.map((review) => review.toMap()).toList(),
      'colors': colors,
     'sizes': sizes,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['_id'] ?? '',
      senderId: map['senderId'] ?? '',
      name: map['name'] ?? '',
      price: map['price']?.toDouble() ?? 0.0, // Convert price to double
      sale: map['sale'] ?? 0.0, // Convert price to double
      description: map['description'] ?? '',
      quantity: map['quantity'] ?? 0, // Default quantity to 0
      category: map['category'] ?? '',
      images: List<String>.from(map['images'] ?? []), // Convert images to list
      reviews: map['reviews'] != null
          ? List<ReviewsModel>.from(
              map['reviews'].map((review) => ReviewsModel.fromMap(review)))
          : null, // Convert reviews to list
          colors: List<String>.from(map['colors'] ?? []), // Convert colors to list
          sizes: List<int>.from(map['sizes'] ?? []), // Convert sizes to list
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
    int? sale,
    String? description,
    int? quantity,
    String? category,
    List<String>? images,
    List<ReviewsModel>? reviews,
    List<String>? colors,
    List<int>? sizes,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      sale: sale ?? this.sale,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      images: images ?? this.images,
      reviews: reviews ?? this.reviews,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
    );
  }
}
