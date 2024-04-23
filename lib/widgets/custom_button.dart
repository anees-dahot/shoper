
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
     height: MediaQuery.of(context).size.height * 0.07,
     width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
       color: color,
       borderRadius: BorderRadius.circular(10)
      ),
      child: Text(
        text,
        style: GoogleFonts.lato(textStyle: TextStyle(
          color: color == null ? Colors.black : Colors.white,
          fontSize: 16
        ),)
      ),
    );
  }
}
