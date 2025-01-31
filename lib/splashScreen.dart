import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shuttleloungenew/const/color.dart';
import 'package:shuttleloungenew/customerModule/bottomNavigationBarScreens/dashboard.dart';
import 'package:shuttleloungenew/expertmodule/expert_dashboard.dart';
import 'package:shuttleloungenew/onboardingscreens/onboarding_screens.dart';
import 'package:shuttleloungenew/sharedPreferences/sharedprefservices.dart';


class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      // showSnackBar(
      //   context,
      //   SharedPrefServices.getrememberme().toString(),
      // );
      // showSnackBar(
      //   context,
      //   SharedPrefServices.getroleCode().toString(),
      // );

      // if (SharedPrefServices.getislogged() == false) {
      //   Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => const Onboardingscreens(),
      //       ));
      // } else if (SharedPrefServices.getislogged() == true) {
      //   if (SharedPrefServices.getroleCode().toString() == "CUST") {
      //     Navigator.of(context).push(
      //       MaterialPageRoute(
      //         builder: (BuildContext context) {
      //           return const Dashboard();
      //         },
      //       ),
      //     );
      //   } else if (SharedPrefServices.getroleCode().toString() == "EXPERT") {
      //     Navigator.of(context).push(
      //       MaterialPageRoute(
      //         builder: (BuildContext context) {
      //           return const ExpertDashboard();
      //         },
      //       ),
      //     );
      //   } else if (SharedPrefServices.getroleCode().toString().isEmpty) {
      //     Navigator.pushReplacement(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => const Onboardingscreens(),
      //         ));
      //   }
      // }

      if (SharedPrefServices.getrememberme().toString() == "true") {
        if (SharedPrefServices.getroleCode().toString() == "CUST") {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const Dashboard();
              },
            ),
          );
        } else if (SharedPrefServices.getroleCode().toString() == "EXPERT") {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const ExpertDashboard();
              },
            ),
          );
        }
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return const Onboardingscreens();
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhiteColor,
      body: Column(
        children: [
          const SizedBox(
            height: 180,
          ),
          Center(
            child: Image.asset(
              "images/appLogo.png",
              height: 250,
              width: 350,
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Center(
            child: Image.asset(
              "images/maintext.png",
              height: 70,
              width: 350,
            ),
          ),
          Center(
            child: Image.asset(
              "images/subtext.png",
              height: 40,
              width: 350,
            ),
          ),

          // CustomText(
          //     text: SharedPrefServices.getislogged().toString(),
          //     fontSize: 35,
          //     fontWeight: FontWeight.w600,
          //     textcolor: kblackColor),
          // Text(SharedPrefServices.getislogged().toString())
        ],
      ),
    );
  }
}
