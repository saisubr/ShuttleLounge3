import 'package:flutter/material.dart';
import 'package:shuttleloungenew/const/color.dart';
import 'package:shuttleloungenew/customerModule/customerSidemenu.dart';
import 'package:shuttleloungenew/sharedPreferences/sharedprefservices.dart';
import 'package:shuttleloungenew/widgets/customtext.dart';


class Graphscreen extends StatelessWidget {
  const Graphscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        backgroundColor: kwhiteColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kwhiteColor,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                scaffoldKey.currentState?.openDrawer();
              },
              child: CircleAvatar(
                backgroundColor: kgreyColor,
                backgroundImage: NetworkImage(
                  SharedPrefServices.getprofileimage().toString(),
                ),
                radius: 10,
              ),
            ),
          ),
          title: const CustomText(
              text: "Shuttle Lounge",
              fontSize: 22,
              fontWeight: FontWeight.w600,
              textcolor: kblackColor),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'images/notification.png',
                height: 25,
                width: 25,
              ),
            )
          ],
        ),
        drawer: const CustomerSideMenu(),
        key: scaffoldKey,
        body: const Center(
          child: CustomText(
              text: "Working Progress",
              fontSize: 18,
              fontWeight: FontWeight.w500,
              textcolor: kblackColor),
        ));
  }
}
