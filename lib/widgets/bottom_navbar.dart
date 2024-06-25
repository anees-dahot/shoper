import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shoper/features/account/screens/account_screen.dart';
import 'package:shoper/features/cart/screen/cart_screen.dart';
import 'package:shoper/features/home/screens/home_screen.dart';
import 'package:shoper/features/wishlist/screens/wishlist_screen.dart'; // For cart badge

class BottomNavbr extends StatefulWidget {
  const BottomNavbr({super.key});

  static const String routeName = '/real-home';

  @override
  State<BottomNavbr> createState() => _BottomNavbrState();
}

class _BottomNavbrState extends State<BottomNavbr> {
  int _selectedIndex = 0;
  final List<Widget> pages = [
    const HomeScreen(), // Replace with your home screen
    const WishlistScreen(), // Replace with your home screen
    // const AccountScreen(), // Replace with your account screen
    const CartScreen(), // Replace with your cart screen
  ];

  void updatePage(int page) {
    setState(() {
      _selectedIndex = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 70,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly, // Center the items
            children: [
              // HOME
              InkWell(
                onTap: () => updatePage(0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: 50,
                  decoration: BoxDecoration(
                    color:
                        _selectedIndex == 0 ? Colors.red : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: FaIcon(
                      _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => updatePage(1),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: 50,
                  decoration: BoxDecoration(
                    color:
                        _selectedIndex == 1 ? Colors.red : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: FaIcon(
                      _selectedIndex == 1 ? CupertinoIcons.heart_fill :CupertinoIcons.heart,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
              // ACCOUNT
              InkWell(
                onTap: () => updatePage(2),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: 50,
                  decoration: BoxDecoration(
                    color:
                        _selectedIndex == 2 ? Colors.red : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: FaIcon(
                      _selectedIndex == 2
                          ? CupertinoIcons.person_fill
                          : CupertinoIcons.person,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
              // CART with Badge (optional)
              InkWell(
                onTap: () => updatePage(3),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: 50,
                  decoration: BoxDecoration(
                    color:
                        _selectedIndex == 3 ? Colors.red : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: badges.Badge(
                      position: badges.BadgePosition.topEnd(top: -8, end: -8),
                      showBadge: true,
                      badgeContent: const Icon(Icons.check,
                          color: Colors.white, size: 10),
                      badgeAnimation: const badges.BadgeAnimation.rotation(
                        animationDuration: Duration(milliseconds: 300),
                        colorChangeAnimationDuration: Duration(seconds: 1),
                        loopAnimation: false,
                        curve: Curves.fastOutSlowIn,
                        colorChangeAnimationCurve: Curves.easeInCubic,
                      ),
                      badgeStyle: const badges.BadgeStyle(
                        elevation: 0,
                      ),
                      child: Icon(
                        _selectedIndex == 3
                            ? CupertinoIcons.cart_fill
                            : CupertinoIcons.cart,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
