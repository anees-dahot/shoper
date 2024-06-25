import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoper/constants/flutter_toast.dart';
import 'package:shoper/features/admin/widgets/admin_bottombar.dart';
import 'package:shoper/features/auth/services/auth_service.dart';
import 'package:shoper/model/product.dart';
import 'package:http/http.dart' as http;
import 'package:shoper/provider/user_controller.dart';
import 'package:shoper/splash_screen.dart';

import '../../../utils.dart';

class AdminService {
  final baseUrl = 'http://192.168.8.107:3000';
      bool saved = true;

  void sellProduct(
      {required BuildContext context,
      required String name,
      required String description,
      required double price,
      required int quantity,
      required String category,
      required List<File> images,
      required List<String> colors,
      required List<int> sizes
      }) async {
    try {
      saved == false;
      final user = userBox.values.first;
      final cloudinary = CloudinaryPublic('doaewaso1', 'one9vigp');
      List<String> imageUrl = [];
      for (int i = 0; i < images.length; i++) {
        final CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imageUrl.add(res.secureUrl);
      }
      print(imageUrl);

      ProductModel productModel = ProductModel(
        name: name,
        senderId: user.name,
        price: price,
        description: description,
        quantity: quantity,
        category: category,
        images: imageUrl,
        colors: colors,
        sizes: sizes,
        sale: 0
      );
      print('model done');

      http.Response res = await http.post(
        Uri.parse('$baseUrl/admin/sell-product'),
        body: productModel.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token
        },
      );
      print('api hit');
      if (res.statusCode == 200) {
        successMessage('Product added successfully');
        Navigator.pushNamed(context, AdminBottomBar.routeName);
      } else if (res.statusCode == 400) {
        errorsMessage(jsonDecode(res.body)['msg']);
        print(jsonDecode(res.body)['msg']);
      } else {
        errorsMessage(
          jsonDecode(res.body)['error'],
        );
        print(jsonDecode(res.body)['error']);
      }
      saved == true;
    } catch (e) {
      errorsMessage(e.toString());
      saved == true;
    }
  }

  Future<List<ProductModel>> getProducts(BuildContext context) async {
    List<ProductModel> products = [];
    final user = userBox.values.first;

    try {
      final res = await http.get(
        Uri.parse('$baseUrl/admin/get-products'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token
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
      errorsMessage(e.toString());
    }
    return products;
  }

  void deleteProduct(String productId, BuildContext context) async {
    final user = userBox.values.first;
    final res = await http.post(
      Uri.parse('$baseUrl/admin/delete-product/$productId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': user.token
      },
    );

    if (res.statusCode == 200) {
      successMessage(jsonDecode(res.body)['message']);
    } else if (res.statusCode == 400) {
      errorsMessage(jsonDecode(res.body)['msg']);
      print("400 ${jsonDecode(res.body)['msg']}");
    } else {
      errorsMessage(
        jsonDecode(res.body)['error'],
      );
      print("500 ${jsonDecode(res.body)['error']}");
    }
  }

  void becomeBuyer(BuildContext context) async {
    final user = userBox.values.first;
    final userId =
        userBox.values.first.id.toString();
    AuthService authService = AuthService();

    final res = await http.post(Uri.parse('$baseUrl/admin/become-buyer'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token
        },
        body: jsonEncode({'id': userId}));
    if (res.statusCode == 200) {
      authService.getUserData(context).then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SplashScreen()),
        );
      }).onError((error, stackTrace) {
        errorsMessage(error.toString());
        print('become buyer then error $error');
      });
    } else if (res.statusCode == 400) {
      errorsMessage(jsonDecode(res.body)['msg']);
      print("400 ${jsonDecode(res.body)['msg']}");
    } else {
      errorsMessage(
        jsonDecode(res.body)['error'],
      );
      print("500 ${jsonDecode(res.body)['error']}");
    }
  }

  void updateProduct(BuildContext context, String? productId, ProductModel productModel) async {
    final user = userBox.values.first;
  

    final res = await http.post(Uri.parse('$baseUrl/admin/update-product/$productId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token
        },
        body: productModel.toJson());
    if (res.statusCode == 200) {
    Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AdminBottomBar()),
        );
      print('Updated');
    } else if (res.statusCode == 400) {
      errorsMessage(jsonDecode(res.body)['msg']);
      print("400 ${jsonDecode(res.body)['msg']}");
    } else {
      errorsMessage(
        jsonDecode(res.body)['error'],
      );
      print("500 ${jsonDecode(res.body)['error']}");
    }
  }
}
  
