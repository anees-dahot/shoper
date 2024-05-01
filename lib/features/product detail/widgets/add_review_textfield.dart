import 'package:flutter/material.dart';

class AddReviewTextField extends StatelessWidget {
  final String hintText;
  TextEditingController controller;
  int? numberOfLines;

  AddReviewTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.numberOfLines,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        maxLines: numberOfLines,
        decoration: InputDecoration(
        
         
          hintText: hintText,
          enabledBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(68, 0, 0, 0), width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter $hintText';
          }
          return null;
        },
      ),
    );
  }
}
