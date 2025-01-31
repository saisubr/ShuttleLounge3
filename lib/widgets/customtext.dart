import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shuttleloungenew/const/color.dart';


class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textcolor;

  const CustomText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    required this.textcolor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
          color: textcolor,
          fontFamily: 'poppins',
          fontSize: fontSize,
          fontWeight: fontWeight,
        )));
  }
}

class CustomViewText extends StatelessWidget {
  final String text;
  final IconData geticon;

  const CustomViewText({
    super.key,
    required this.text,
    required this.geticon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: kgreyColor),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, top: 5),
        child: Row(
          children: [
            Icon(
              geticon,
              color: kblackColor,
              size: 22,
            ),
            const SizedBox(
              width: 10,
            ),
            CustomText(
                text: text,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                textcolor: kblackColor)
          ],
        ),
      ),
    );
  }
}
