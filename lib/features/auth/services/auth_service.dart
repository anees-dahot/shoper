// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoper/features/admin/widgets/admin_bottombar.dart';
import 'package:shoper/utils.dart';
import 'package:shoper/widgets/bottom_navbar.dart';
import '../../../constants/flutter_toast.dart';
import '../../../model/user.dart';
import '../../../provider/user_controller.dart';
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
      );

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

        UserModel userModel = UserModel(
            id: userData['_id'],
            name: userData['name'],
            email: userData['email'],
            password: userData['password'],
            address: userData['address'],
            type: userData['type'],
            token: userData['token']);

        userBox.add(userModel);
        print(userBox.values.first.name);
        await getUserData(context);
        Navigator.pushNamedAndRemoveUntil(
          context,
          BottomNavbr.routeName,
          (route) => false,
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
      print('error $e');
    }
  }

  // get user data
  Future<void> getUserData(
    BuildContext context,
  ) async {
    try {
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

        if (userBox.values.first.token.length == 0) {
          UserModel userModel = UserModel(
              id: userData['_id'],
              name: userData['name'],
              email: userData['email'],
              password: userData['password'],
              address: userData['address'],
              type: userData['type'],
              token: token);

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
    // UserController userController = Get.put(UserController());

    final user = userBox.values.first;

    final res = await http.post(
        Uri.parse('$baseUrl/api/become-seller/${user.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token
        });

    if (res.statusCode == 200) {
      userBox.values.first.type == 'seller';
      
      userBox.values.first.save();
      getUserData(context).then((value) {
        Navigator.pushNamed(context, AdminBottomBar.routeName);
      }).onError((error, stackTrace) {
        // errorsMessage(error.toString());
        print('become seller then error $error');
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
}
