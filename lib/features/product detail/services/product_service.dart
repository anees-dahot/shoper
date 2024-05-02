import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shoper/constants/flutter_toast.dart';
import 'package:shoper/model/reviews.dart';
import '../../../provider/user_controller.dart';

class ProductSerivce {
  final baseUrl = 'http://192.168.8.104:3000';

  Future<void> postReview(
      {required BuildContext context,
      required String review,
      required String time,
      required int stars,
      required String productId}) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;

    try {
      ReviewsModel reviewsModel = ReviewsModel(
          user: user.name, review: review, time: time, stars: stars);
      final res = await http.post(
        Uri.parse('$baseUrl/admin/post-review/$productId'),
        body: reviewsModel.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token
        },
      );

      if (res.statusCode == 200) {
        print(res.body);
      } else if (res.statusCode == 400) {
        errorsMessage(jsonDecode(res.body)['msg']);
        print("400 ${jsonDecode(res.body)['msg']}");
      } else {
        errorsMessage(
          jsonDecode(res.body)['error'],
        );
        print("500 ${jsonDecode(res.body)['error']}");
      }
    } catch (e) {
      errorsMessage(e.toString());
    }
  }


Future<Map<String, dynamic>> fetchReviews(String productId, BuildContext context) async {

   final user = Provider.of<UserProvider>(context, listen: false).user;
  final url = Uri.parse('$baseUrl/admin/get-reviews/$productId');
  final response = await http.get(url,  headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token
        },);

  if (response.statusCode == 200) {
    print(response.body);
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to fetch reviews: ${response.statusCode}');
  }
}
}
