import 'package:flutter/material.dart';


class CustomTextFIeldAdmin extends StatelessWidget {
   CustomTextFIeldAdmin({
    super.key,
    required this.width,
    required this.height,
    required this.hintText, 
    this.numberOfLines,
    required this.controller,
  });

  final double width;
  final double height;
  final String hintText;
  final TextEditingController controller;
  int? numberOfLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 246, 244, 244),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              width: 1, color: const Color.fromARGB(255, 187, 187, 187))),
      child: TextFormField(
        controller: controller,
        maxLines: numberOfLines,
        decoration: InputDecoration(
            hintText: hintText,
            border: const OutlineInputBorder(borderSide: BorderSide.none)),
       validator: (value) {
        if (value!.isEmpty || value == '') {
          return 'Please enter your $hintText';
        }
        return null;
      },  
      ),
    );
  }
}
