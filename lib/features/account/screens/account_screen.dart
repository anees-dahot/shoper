import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoper/features/account/widgets/profile_buttons.dart';
import 'package:shoper/features/account/widgets/your_orders.dart';
import 'package:shoper/features/account/widgets/bottom_appbar.dart';
import 'package:shoper/provider/user_controller.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          BottomAppbar(user: user,),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ProfileButtons(
                text: 'Your Orders',
                onTap: () {},
              ),
              ProfileButtons(
                text: 'Turn Seller',
                onTap: () {},
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
                onTap: () {},
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

