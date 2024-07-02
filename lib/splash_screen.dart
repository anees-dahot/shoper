import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoper/features/auth/services/auth_service.dart';
import 'package:shoper/features/admin/widgets/admin_bottombar.dart';
import 'package:shoper/utils.dart';
import 'package:shoper/widgets/bottom_navbar.dart';

import 'features/auth/screens/loginscreen.dart';
import 'model/user.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName =  'splash-screen';
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
    
  
  }


  void screenNavigator()async {
 await Hive.openBox<UserModel>('user');
     if(userBox.isNotEmpty){
      final SharedPreferences ref = await SharedPreferences.getInstance();
        String? token = ref.getString('x-auth-token');
    authService.getUserData().then((value) {
   print(userBox.values.first.id)
;      // Future.delayed(const Duration(seconds: 10), () {
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
     }else{
      Navigator.pushNamed(context, AuthScreen.routeName);
     }
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
