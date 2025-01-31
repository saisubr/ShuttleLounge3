import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:introduction_screen/introduction_screen.dart';
import 'package:shuttleloungenew/const/color.dart';
import 'package:shuttleloungenew/customerModule/customerLogin/loginscreen.dart';
import 'package:shuttleloungenew/widgets/customtext.dart';


class Onboardingscreens extends StatefulWidget {
  const Onboardingscreens({Key? key}) : super(key: key);

  @override
  OnboardingscreensState createState() => OnboardingscreensState();
}

class OnboardingscreensState extends State<Onboardingscreens> {
  final introKey = GlobalKey<IntroductionScreenState>();
  void _onIntroEnd(context) {}

  Widget _column(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: Image.asset(
              "images/maintext.png",
              height: 70,
              width: 350,
            ),
          ),
          // CustomText(
          //     text: 'Shuttle Lounge',
          //     fontSize: 24,
          //     fontWeight: FontWeight.w600,
          //     textcolor: kblackColor),
          SizedBox(
            height: 10,
          ),
          CustomText(
            text: 'Find your way to perfection',
            fontSize: 15,
            fontWeight: FontWeight.w400,
            textcolor: kblackColor,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String assetName,
      [double width = 360, double height = 250]) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: 120.0,
          child: Image.asset('images/$assetName', width: width, height: height),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: kwhiteColor,
      imagePadding: EdgeInsets.zero,
    );

    return Stack(
      children: [
        IntroductionScreen(
          key: introKey,
          globalBackgroundColor: kwhiteColor,
          allowImplicitScrolling: true,
          autoScrollDuration: 3000,
          infiniteAutoScroll: true,
          pages: [
            PageViewModel(
              body: '',
              title: '',
              image: _buildImage(
                'cockimage.png',
              ),
              footer: _column(context),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "",
              body: "",
              footer: _column(context),
              image: _buildImage('playshuttle.png'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "",
              body: "",
              footer: _column(context),
              image: _buildImage('shuttlecourt.png'),
              decoration: pageDecoration,
            ),
            PageViewModel(
                title: "",
                body: "",
                footer: _column(context),
                image: _buildImage('shuttlelogos.png')),
          ],
          onDone: () => _onIntroEnd(context),
          onSkip: () => _onIntroEnd(context),
          showSkipButton: false,
          showDoneButton: false,
          showNextButton: false,
          skipOrBackFlex: 0,
          nextFlex: 0,
          showBackButton: false,
          skip: const Text('Skip',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: kblackColor,
              )),
          next: const Icon(
            Icons.arrow_forward,
            size: 30,
            color: kblackColor,
          ),
          done: const Text('Done',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: kblackColor,
              )),
          curve: Curves.fastLinearToSlowEaseIn,
          controlsMargin: const EdgeInsets.all(16),
          controlsPadding: kIsWeb
              ? const EdgeInsets.all(12.0)
              : const EdgeInsets.only(bottom: 100),
          dotsDecorator: const DotsDecorator(
            size: Size(10, 10),
            color: kgreyColor,
            activeSize: Size(22.0, 10.0),
            activeColor: kredColor,
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: SizedBox(
              height: 60,
              width: 190,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Loginscreen()));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: kblackColor,
                  elevation: 5,
                ),
                child: const CustomText(
                  text: 'Get Started',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  textcolor: kwhiteColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
