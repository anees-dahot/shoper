import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoper/features/home/provider/home_controller.dart';
import 'package:shoper/features/home/widgets/category_widget.dart';
import 'package:shoper/features/home/widgets/deal_of_the_day.dart';
import 'package:shoper/features/home/widgets/new_arrivals.dart';
import 'package:shoper/features/home/widgets/on_sale.dart';
import 'package:shoper/features/home/widgets/search_bar.dart';
import 'package:shoper/utils.dart';
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
    print(userBox.values.first.type);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
   HomeController homeController = Get.put(HomeController());
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          height: height * 0.05,
        ),
        CustomSearchBar(width: width, height: height),
        SizedBox(
          height: height * 0.025,
        ),
        //make a container for showing shop now banner with an image text adn button adn red bg color
        CustomBanner(width: width, height: height),
        SizedBox(height: height * 0.04),
        CategoryWidget(),
        Obx(
          () => homeController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : (homeController.newArrivalProducts.isNotEmpty
                  ? NewArrivals()
                  : const SizedBox()), // Empty container while loading or no products
        ),
        Obx(
          () => homeController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : (homeController.saleProducts.isNotEmpty
                  ? OnSale()
                  : const SizedBox()), // Empty container while loading or no products
        ),
        Obx(
          () => homeController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : (homeController.trendingProducts.isNotEmpty
                  ? DealOFDay()
                  : const SizedBox()), // Empty container while loading or no products
        ),

        SizedBox(height: height * 0.09),
      ]),
    ));
  }
}
