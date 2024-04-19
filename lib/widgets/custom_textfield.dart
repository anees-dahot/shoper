import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  TextEditingController controller;

  CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(68, 0, 0, 0), width: 2.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange, width: 2.0),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your $hintText';
        }
        return null;
      },
    );
  }
}
