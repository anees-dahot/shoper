import 'package:flutter/material.dart';
import 'package:shoper/features/home/screens/category_products.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget({super.key});

  List category = [
    {
      "name": "Adidas",
      "image": 'assets/images/adidas.png',
    },
    {
      "name": "Nike",
      "image": 'assets/images/nike.png',
    },
    {
      "name": "Puma",
      "image": 'assets/images/puma.png',
    },
    {
      "name": "Converse",
      "image": 'assets/images/converse.png',
    },
     {
      "name": "Gucci",
      "image": 'assets/images/gucci.png',
    },
    {
      "name": "Skechers",
      "image": 'assets/images/skechers.png',
    },
    {
      "name": "Power",
      "image": 'assets/images/power.png',
    },
    {
      "name": "Bata",
      "image": 'assets/images/bata.png',
    },
     
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.14,
      child: ListView.builder(
        itemCount: category.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal:  15.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, CategoryProducts.routeName, arguments: category[index]['name']),
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          color: Colors.grey[200]),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          category[index]['image'],
                        ),
                      ),
                    ),
                  ),
                  Text(category[index]['name'])
                ],
              ));
        },
      ),
    );
  }
}
