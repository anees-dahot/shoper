import 'package:flutter/material.dart';
import 'package:shoper/features/auth/services/auth_service.dart';
import 'package:shoper/features/admin/widgets/admin_bottombar.dart';
import 'package:shoper/utils.dart';
import 'package:shoper/widgets/bottom_navbar.dart';

import 'features/auth/screens/loginscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    screenNavigator();
    authService.getUserData(context);
    
  }


  void screenNavigator()async {
    //  final SharedPreferences ref = await SharedPreferences.getInstance();
        // String? token = ref.getString('x-auth-token');
    authService.getUserData(context).then((value) {
   
      // Future.delayed(const Duration(seconds: 10), () {
       userBox.values.first.token.isNotEmpty
            ? userBox.values.first.type ==
                    'user'
                ? Navigator.pushNamedAndRemoveUntil(
                    context, BottomNavbr.routeName, (route) => false)
                : Navigator.pushNamedAndRemoveUntil(
                    context, AdminBottomBar.routeName, (route) => false)
            : Navigator.pushNamedAndRemoveUntil(
                context, AuthScreen.routeName, (route) => false);
      // });
    }).onError((error, stackTrace) {
      print('splash error $error');
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
