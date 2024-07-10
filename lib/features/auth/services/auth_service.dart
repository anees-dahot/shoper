// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoper/features/admin/widgets/admin_bottombar.dart';
import 'package:shoper/features/auth/screens/loginscreen.dart';
import 'package:shoper/utils.dart';
import '../../../constants/flutter_toast.dart';
import '../../../model/user.dart';
import '../../../splash_screen.dart';

class AuthService {
  // sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserModel user = UserModel(
          id: '',
          name: name,
          password: password,
          email: email,
          address: '',
          type: '',
          token: '',
          cartItems: []);

      http.Response res = await http.post(
        Uri.parse('$baseUrl/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Logged in successfully',
            ),
          ),
        );
      } else if (res.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonDecode(res.body)['msg'])),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              jsonDecode(res.body)['error'],
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  // sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      //  ProductDetailController productDetailController = Get.put(ProductDetailController());
      //  productDetailController.getCartItems();
      http.Response res = await http.post(
        Uri.parse('$baseUrl/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Logged in successfully',
            ),
          ),
        );

        final SharedPreferences ref = await SharedPreferences.getInstance();
        ref.setString('x-auth-token', jsonDecode(res.body)['token']);
        var userData = jsonDecode(res.body);
        var token = jsonDecode(res.body)['token'];
        if (userBox.values.isEmpty || userBox.values.first.token.isEmpty) {
          UserModel userModel = UserModel(
            id: userData['_id'],
            name: userData['name'],
            email: userData['email'],
            password: userData['password'],
            address: userData['address'],
            type: userData['type'],
            token: token,
          );

          try {
            await userBox.add(userModel);
            print('User added successfully');
            Navigator.pushNamedAndRemoveUntil(
              context,
              SplashScreen.routeName,
              (route) => false,
            );
          } catch (error) {
            print('Error saving user: $error');
            // Handle the error appropriately
          }
        } else {
          userBox.values
          .where((element) => element.id == userBox.values.first.id)
          .first
          .token = token;

      userBox.values
          .where((element) => element.id == userBox.values.first.id)
          .first
          .save();
          print('User already exists');
          // Maybe update the existing user instead?
        }
      } else if (res.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonDecode(res.body)['msg'])),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              jsonDecode(res.body)['error'],
            ),
          ),
        );
      }
      //  userBox.values.; 
    } catch (e) {
      print('error $e');
    }
  }

  // get user data
  Future<void> getUserData() async {
    try {
      //    ProductDetailController productDetailController = Get.put(ProductDetailController());
      //  productDetailController.getCartItems();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$baseUrl/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$baseUrl/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userData = jsonDecode(userRes.body);
        print('id: ${userBox.values.length}');

        if (userBox.values.first.token.isEmpty) {
          UserModel userModel = UserModel(
            id: userData['_id'],
            name: userData['name'],
            email: userData['email'],
            password: userData['password'],
            address: userData['address'],
            type: userData['type'],
            token: token,
            // cartItems:productDetailController.cartItems.isNotEmpty ? productDetailController.cartItems : []
          );

          await userBox.add(userModel);
        } else {
          print('user already exists');
        }
      }
    } catch (e) {
      // showSnackBar(context, e.toString());
      print('error 2nd $e');
    }
  }

  void becomeSeller(BuildContext context) async {
    final user = userBox.values.first;

    final res = await http.post(
        Uri.parse('$baseUrl/api/become-seller/${user.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token
        });

    if (res.statusCode == 200) {
      // Create a new user object with the updated type
      final updatedUser = UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        password: user.password,
        address: user.address,
        type: 'seller', // Update the type to 'seller'
        token: user.token,
      );

      // Update the user in the Hive box
      await userBox.putAt(0, updatedUser);

      await getUserData();
      Navigator.pushNamed(context, AdminBottomBar.routeName);
    } else if (res.statusCode == 400) {
      errorsMessage(jsonDecode(res.body)['msg']);
      print("400 ${jsonDecode(res.body)['msg']}");
    } else {
      errorsMessage(jsonDecode(res.body)['error']);
      print("500 ${jsonDecode(res.body)['error']}");
    }
  }

  void logoutUser(BuildContext context) {
    try {
      userBox.values
          .where((element) => element.id == userBox.values.first.id)
          .first
          .token = '';

      userBox.values
          .where((element) => element.id == userBox.values.first.id)
          .first
          .save();
      Navigator.pushNamed(context, AuthScreen.routeName);
    } catch (e) {
      errorsMessage(e.toString());
    }
  }
}
