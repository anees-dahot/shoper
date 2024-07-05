import 'package:flutter/material.dart';
import 'package:shoper/features/account/widgets/profile_buttons.dart';
import 'package:shoper/features/account/widgets/your_orders.dart';
import 'package:shoper/features/account/widgets/bottom_appbar.dart';
import 'package:shoper/features/auth/services/auth_service.dart';
import '../../../splash_screen.dart';
import '../../../utils.dart';
import '../../orders/screen/orders_screen.dart';
import '../../wishlist/screens/wishlist_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = userBox.values.first;
    AuthService authService = AuthService();
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          BottomAppbar(
            user: user,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ProfileButtons(
                text: 'Your Orders',
                onTap: () {
                  Navigator.pushNamed(context, OrdersPage.routeName);
                },
              ),
              ProfileButtons(
                text: 'Become Seller',
                onTap: () {
                  authService.becomeSeller(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SplashScreen()),
                  );
                },
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ProfileButtons(
                text: 'Your Wishlist',
                onTap: () {
                  Navigator.pushNamed(context, WishlistScreen.routeName);
                },
              ),
              ProfileButtons(
                text: 'Log Out',
                onTap: () {},
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          YourOrdersWidget()
        ],
      ),
    );
  }
}
