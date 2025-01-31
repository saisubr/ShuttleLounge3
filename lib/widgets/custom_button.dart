import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;

  const CustomButton(
      {super.key,
      required this.text,
      required this.textColor,
      required this.onPressed,
      required this.color,
      required this.fontSize,
      required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: SizedBox(
            height: 45,
            child: Center(
                child: Text(
              text,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                color: textColor,
                fontFamily: 'poppins',
                fontSize: fontSize,
                fontWeight: fontWeight,
              )),
            ))));
  }
}
