import 'dart:convert';

import 'package:hive/hive.dart';
part 'reviews.g.dart';

@HiveType(typeId: 2)
class ReviewsModel  extends HiveObject {
  final String user;
  final String review;
  final String time;
  final int stars;

  ReviewsModel({
   required  this.user,
   required this.review,
    required this.time, required this.stars,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'review': review,
      'time': time,
      'stars': stars,
    };
  }

  factory ReviewsModel.fromMap(Map<String, dynamic> map) {
    return ReviewsModel(
      user: map['user'] ?? '',
      review: map['review'] ?? '',
      time: map['time'] ?? '',
      stars: map['stars'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewsModel.fromJson(String source) =>
      ReviewsModel.fromMap(json.decode(source));

  ReviewsModel copyWith({
    String? user,
    String? review,
    String? time,
    int? stars,
  }) {
    return ReviewsModel(
      user: user ?? this.user,
      review: review ?? this.review,
      time: time ?? this.time,
      stars: stars?.toInt() ?? this.stars,
    );
  }
}
