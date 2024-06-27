// import 'dart:convert';

// import 'package:hive/hive.dart';
// part 'cart.g.dart';

// @HiveType(typeId: 3)
// class CartModel extends HiveObject {
//   @HiveField(0)
//   final String productName;
//   @HiveField(1)
//   final String imageUrl;
//   @HiveField(2)
//   final int quantity;
//   @HiveField(3)
//   final double totalPrice;
//   @HiveField(3)
//   final String description;

//   CartModel({
//     required this.productName,
//     required this.imageUrl,
//     required this.quantity,
//     required this.totalPrice,
//     required this.description,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'productName': productName,
//       'imageUrl': imageUrl,
//       'quantity': quantity,
//       'totalPrice': totalPrice,
//     };
//   }

//   factory CartModel.fromMap(Map<String, dynamic> map) {
//     return CartModel(
//       description: map['description'] ?? '',
//       productName: map['productName'] ?? '',
//       imageUrl: map['imageUrl'] ?? '',
//       quantity: map['quantity'] ?? 0,
//       totalPrice: map['totalPrice'] ?? 0.0,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory CartModel.fromJson(String source) =>
//       CartModel.fromMap(json.decode(source));

//   CartModel copyWith({
//     String? productName,
//     String? imageUrl,
//     String? quantity,
//     int? totalPrice,
//     String? description
//   }) {
//     return CartModel(
//       productName: productName ?? this.productName,
//       imageUrl: imageUrl ?? this.imageUrl,
//       quantity: int.parse(quantity!) ?? this.quantity,
//       totalPrice: totalPrice!.toDouble() ?? this.totalPrice,
//       description: description ?? this.description
//     );
//   }
// }
