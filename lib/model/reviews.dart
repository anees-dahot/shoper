import 'dart:convert';

class ReviewsModel {
  final String user;
  final String review;
  final String time;

  ReviewsModel({
   required  this.user,
   required this.review,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'review': review,
      'time': time,
    };
  }

  factory ReviewsModel.fromMap(Map<String, dynamic> map) {
    return ReviewsModel(
      user: map['user'] ?? '',
      review: map['review'] ?? '',
      time: map['time'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewsModel.fromJson(String source) =>
      ReviewsModel.fromMap(json.decode(source));

  ReviewsModel copyWith({
    String? user,
    String? review,
    String? time,
  }) {
    return ReviewsModel(
      user: user ?? this.user,
      review: review ?? this.review,
      time: time ?? this.time,
    );
  }
}
