import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBanner extends StatelessWidget {
  const CustomBanner({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: width * 0.94,
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
               Text(
                'Converse x',
                style:
                    GoogleFonts.lato(textStyle: const TextStyle(fontSize: 28, color: Colors.white, height: 0, )),
              ),
               Text(
                'DRKSHDW',
                style:
                   GoogleFonts.lato(textStyle: const TextStyle(fontSize: 26, color: Colors.white, height: 1, )),
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
                child: const Center(
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
    );
  }
}