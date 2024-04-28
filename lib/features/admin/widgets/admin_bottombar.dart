import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shoper/features/admin/screens/analytics_Screen.dart';
import 'package:shoper/features/admin/screens/orders_screen.dart';

import '../screens/home_screen.dart'; // For cart badge

class AdminBottomBar extends StatefulWidget {
  const AdminBottomBar({super.key});

  static const String routeName = '/dashboard';

  @override
  State<AdminBottomBar> createState() => _BottomNavbrState();
}

class _BottomNavbrState extends State<AdminBottomBar> {
  int _selectedIndex = 0;
  final List<Widget> pages = [
     DashboardScreen(), // Replace with your home screen
    const AnalyticsScreen(), // Replace with your home screen
    const OrdersScreen(), // Replace with your account screen
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
          width: MediaQuery.of(context).size.width * 0.7,
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
                      _selectedIndex == 1
                          ? CupertinoIcons.chart_bar_fill
                          : CupertinoIcons.chart_bar,
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
                          ? Icons.shopping_bag
                          : Icons.shopping_bag_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
              // CART with Badge (optional)
            ],
          ),
        ),
      ),
    );
  }
}
