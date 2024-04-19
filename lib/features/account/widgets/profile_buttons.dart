import 'package:flutter/material.dart';

class ProfileButtons extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const ProfileButtons({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width * 0.43,
        height: 55,
        decoration: BoxDecoration(
            color:  Colors.black,
            border: Border.all(
              width: 1,
              color: const Color.fromARGB(255, 173, 172, 172),
            ),
            borderRadius: BorderRadius.circular(25)),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16,  color: Colors.white),
          ),
        ),
      ),
    );
  }
}
