import 'package:flutter/material.dart';
import 'package:shuttleloungenew/const/color.dart';
import 'package:shuttleloungenew/widgets/customtext.dart';


class ReviewImages extends StatelessWidget {
  final String title;
  final ImageProvider image;

  const ReviewImages({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 3,
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                child: Image(
                  image: image,
                  fit: BoxFit.cover,
                )),
          ),
          Container(
            height: 50,
            width: double.infinity,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                color: kwhiteColor),
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomText(
                    text: title,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    textcolor: kblackColor)),
          ),
        ],
      ),
    );
  }
}
