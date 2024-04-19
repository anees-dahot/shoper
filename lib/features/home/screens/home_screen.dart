import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoper/features/home/widgets/category_widget.dart';
import 'package:shoper/features/home/widgets/deal_of_the_day.dart';
import 'package:shoper/features/home/widgets/new_arrivals.dart';
import 'package:shoper/features/home/widgets/on_sale.dart';
import 'package:shoper/features/home/widgets/search_bar.dart';
import '../../../provider/user_controller.dart';
import '../widgets/custom_banner.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          height: height * 0.05,
        ),
        CustomSearchBar(width: width, height: height),
        SizedBox(
          height: height * 0.02,
        ),
        //make a container for showing shop now banner with an image text adn button adn red bg color
        CustomBanner(width: width, height: height),
        SizedBox(height: height * 0.04),
        CategoryWidget(),
        NewArrivals(),
      
        OnSale(),
        DealOfTheDay(),
      ]),
    ));
  }
}
