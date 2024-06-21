import 'package:flutter/material.dart';
import 'package:shoper/features/admin/screens/add_product.dart';
import 'package:shoper/features/admin/widgets/admin_bottombar.dart';
import 'package:shoper/features/category/screen/category_products.dart';
import 'package:shoper/features/product%20detail/screen/product_detail.dart';
import 'package:shoper/features/search/screen/search_products.dart';
import 'package:shoper/model/product.dart';
import 'package:shoper/widgets/bottom_navbar.dart';
import '/features/auth/screens/loginscreen.dart';

import 'features/admin/screens/home_screen.dart';
import 'features/home/screens/home_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case ProductDetail.routeName:
      final product = routeSettings.arguments as ProductModel;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetail(
          products: product,
        ),
      );
    case SearchProducts.routeName:
      final query = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchProducts(
          query: query,
        ),
      );
    case CategoryProducts.routeName:
      final arguments = routeSettings.arguments;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryProducts(
          category: arguments.toString(),
        ),
      );
    case DashboardScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const DashboardScreen(),
      );
    case BottomNavbr.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomNavbr(),
      );
    case AdminBottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminBottomBar(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case AddProduct.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProduct(),
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
