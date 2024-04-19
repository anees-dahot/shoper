import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoper/features/home/screens/home_screen.dart';
import 'package:shoper/splash_screen.dart';
import './features/auth/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './provider/user_controller.dart';
import './widgets/bottom_navbar.dart';
import './features/auth/screens/loginscreen.dart';
import './router.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthService authService = AuthService();
   String? tok;


 void getToken() {
    Future<String?> prefs = SharedPreferences.getInstance().then((value) {
      String? token = value.getString('x-auth-token');
     tok = token;
     return null;
    });
  }


  

  

  @override
 

  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amazon Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme.light(
          primary: Colors.red,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        useMaterial3: true, // can remove this line
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context, listen: false).user.token.isNotEmpty
        ? const BottomNavbr()
        : const SplashScreen()
    );
  }
}
