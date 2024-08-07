import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoper/constants/flutter_toast.dart';
import 'package:shoper/model/reviews.dart';
import '../../../model/product.dart';
import '../../../utils.dart';

class ProductSerivce {
  List<ProductModel> products = [];

  Future<void> postReview(
      {required BuildContext context,
      required String review,
      required String time,
      required int stars,
      required String productId}) async {
    final user = userBox.values.first;

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

  Future<List<ReviewsModel>> fetchReviews(String productId) async {
    List<ReviewsModel> reviews = [];
    try {
      final user = userBox.values.first;
      final url = Uri.parse('$baseUrl/admin/get-reviews/$productId');
      final res = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token
        },
      );

      if (res.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(res.body)['reviews'];
        reviews = jsonData.map((json) => ReviewsModel.fromMap(json)).toList();
        print(reviews);
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
      // errorsMessage(e.toString());
      print(e.toString());
    }
    return reviews;
  }

  Future<List<ProductModel>> getTrendingProducts() async {
    final userToken = userBox.values.first.token;
    List<ProductModel> products = [];
    try {
      final res = await http.get(
        Uri.parse('$baseUrl/api/product/trending-products'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userToken
        },
      );

      if (res.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(res.body)['products'];
        products = jsonData.map((json) => ProductModel.fromMap(json)).toList();
        print(products);
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
      print('cathc error $e');
    }
    return products;
  }

  Future<List<ProductModel>> getNewArrivalProducts() async {
    final userToken = userBox.values.first.token;
    List<ProductModel> products = [];
    try {
      DateTime sdate = DateTime.now().subtract(const Duration(days: 5));
      DateTime edate = DateTime.now().add(const Duration(days: 1));
      String startDate =
          '${sdate.year}-${sdate.month}-${sdate.day}'; // Replace with your desired start date
      String endDate =
          '${edate.year}-${edate.month}-${edate.day}'; // Replace with your desired end date
      final res = await http.get(
        Uri.parse(
          '$baseUrl/api/product/new-arrivals?startDate=$startDate&endDate=$endDate',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userToken
        },
      );

      if (res.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(res.body);
        products = jsonData.map((json) => ProductModel.fromMap(json)).toList();
        print(products);
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
      print('cathc error $e');
    }
    return products;
  }

  Future<List<ProductModel>> getSaleProducts() async {
    final userToken = userBox.values.first.token;
    List<ProductModel> products = [];
    try {
      final res = await http.get(
        Uri.parse('$baseUrl/admin/get-saleproducts'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userToken
        },
      );

      if (res.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(res.body)['products'];
        products = jsonData.map((json) => ProductModel.fromMap(json)).toList();
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
      print('cathc error $e');
    }
    return products;
  }

  Future<List<ProductModel>> getProducts(BuildContext context) async {
    final userToken = userBox.values.first.token;
    // List<ProductModel> products = [];
    try {
      final res = await http.get(
        Uri.parse('$baseUrl/api/product/get-products'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userToken
        },
      );

      if (res.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(res.body)['products'];
        products = jsonData.map((json) => ProductModel.fromMap(json)).toList();
        print(products);
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
      print('cathc error $e');
    }
    return products;
  }
}
