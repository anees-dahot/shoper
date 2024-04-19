import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoper/features/home/widgets/search_bar.dart';
import '../../../provider/user_controller.dart';

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
        body: Column(children: [
      SizedBox(
        height: height * 0.05,
      ),
      CustomSearchBar(width: width, height: height),
      SizedBox(
        height: height * 0.02,
      ),
      //make a container for showing shop now banner with an image text adn button adn red bg color
      Container(
        padding: EdgeInsets.all(15),
        width: width * 0.9,
        height: height * 0.2,
        decoration: BoxDecoration(
          color: Colors.red[400],
          borderRadius: BorderRadius.circular(25),
        ),
        child:
            //* design it with a beautiful heading with text para a button adn image on right side.. im to you AI..
            Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Converse x',
                  style:
                      TextStyle(fontSize: 28, color: Colors.white, height: 0),
                ),
                const Text(
                  'DRKSHDW',
                  style:
                      TextStyle(fontSize: 28, color: Colors.white, height: 1),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  width: width * 0.3,
                  height: height * 0.05,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25)),
                  child: Center(
                    child: Text(
                      'Shop Now',
                      style: TextStyle(
                          fontSize: 15, color: Colors.white, height: 1),
                    ),
                  ),
                )
              ],
            ),
            Image.network(
              'http://www.winkelstraat.nl/cdn-cgi/image/w=1280,h=1280,format=auto/img/2700/2700/trim/catalog/product/2/8/2834168_wsnl344-21-2-292-image_2.jpeg',
            )
          ],
        ),
      )
    ]));
  }
}



