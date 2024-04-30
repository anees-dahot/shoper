import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shoper/features/home/screens/search_products.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchProducts.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: widget.width * 0.75,
          height: widget.height * 0.07,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: navigateToSearchScreen,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  prefixIcon: Icon(Icons.search)),
            ),
          ),
        ),
        SizedBox(
          width: widget.width * 0.03,
        ),
        Container(
          width: widget.width * 0.13,
          height: widget.height * 0.07,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(FontAwesomeIcons.microphone),
        )
      ],
    );
  }
}
