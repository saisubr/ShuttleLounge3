import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shuttleloungenew/const/color.dart';


class ProgressBarHUD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Stack(
        children: [
          Opacity(
            opacity: 0.3,
            child: ModalBarrier(
              dismissible: false,
              color: kwhiteColor,
            ),
          ),
          Center(
            child: SpinKitSpinningLines(
              itemCount: 5,
              color: kgreyColor,
              lineWidth: 5,
              size: 100,
            ),
          ),
        ],
      ),
    );
  }
}
