import 'package:flutter/material.dart';
import 'package:shoper/widgets/bottom_navbar.dart';
import '/features/auth/screens/loginscreen.dart';

import 'features/home/screens/home_screen.dart';


Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case BottomNavbr.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomNavbr(),
      );   

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
