// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  TextEditingController controller;
  int? numberOfLines;
  String? labelText;

  CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.numberOfLines,
     this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      controller: controller,
        maxLines: numberOfLines,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        enabledBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(68, 0, 0, 0), width: 2.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0),
        ),
        errorBorder:  const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        focusedErrorBorder:  const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter $hintText';
        }
        return null;
      },
    );
  }
}
