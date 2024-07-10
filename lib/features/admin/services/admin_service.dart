import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:shoper/constants/flutter_toast.dart';
import 'package:shoper/features/admin/widgets/admin_bottombar.dart';
import 'package:shoper/features/auth/services/auth_service.dart';
import 'package:shoper/model/product.dart';
import 'package:http/http.dart' as http;
import 'package:shoper/widgets/bottom_navbar.dart';

import '../../../model/order.dart';
import '../../../model/user.dart';
import '../../../utils.dart';

class AdminService {
 
 

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
      final user = userBox.values.first;
      final cloudinary = CloudinaryPublic('doaewaso1', 'one9vigp');
      List<String> imageUrl = [];
      for (int i = 0; i < images.length; i++) {
        final CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imageUrl.add(res.secureUrl);
      }

      ProductModel productModel = ProductModel(
        name: name,
        seller: user.id,
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
    } catch (e) {
      errorsMessage(e.toString());
      print(e.toString());
    }
  }

  Future<List<ProductModel>> getProducts() async {
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

  void deleteOrder(String orderId) async {
    final user = userBox.values.first;
    final res = await http.post(
      Uri.parse('$baseUrl/api/orders/delete/$orderId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': user.token
      },
    );

    if (res.statusCode == 200) {
      successMessage(jsonDecode(res.body)['msg']);
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
    AuthService authService = AuthService();
    final userId =
        userBox.values.first.id.toString();
   

    final res = await http.post(Uri.parse('$baseUrl/admin/become-buyer'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token
        },
        body: jsonEncode({'id': userId}));
    if (res.statusCode == 200) {
     final updatedUser = UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      password: user.password,
      address: user.address,
      type: 'user',  // Update the type to 'seller'
      token: user.token,
      
    );

    // Update the user in the Hive box
    await userBox.putAt(0, updatedUser);

    await authService.getUserData();
    Navigator.pushNamed(context, BottomNavbr.routeName);
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

  void markAsCompleted(String orderId) async {
    final user = userBox.values.first;
  

    final res = await http.post(Uri.parse('$baseUrl/api/orders/complete/$orderId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token
        },
       );
    if (res.statusCode == 200) {
   successMessage(jsonDecode(res.body)['message']);
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

  Future<List<Order>> getOrders() async {
    List<Order> orders = [];
    try {
      final user = userBox.values.first;

      final res = await http.get(
        Uri.parse('$baseUrl/api/orders/seller/${user.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token
        },
      );

      if (res.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(res.body)['orders'];
        orders = jsonData.map((json) => Order.fromJson(json)).toList();
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
      print(e.toString());
    }
    return orders;
  }



}
  
