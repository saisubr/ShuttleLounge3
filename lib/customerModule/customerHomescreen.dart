import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shuttleloungenew/const/color.dart';
import 'package:shuttleloungenew/customerModule/customerReviews/requestedtab.dart';
import 'package:shuttleloungenew/customerModule/customerReviews/reviewedtab.dart';
import 'package:shuttleloungenew/customerModule/customerSidemenu.dart';
import 'package:shuttleloungenew/sharedPreferences/sharedprefservices.dart';
import 'package:shuttleloungenew/widgets/customtext.dart';


class CustomerHomescreen extends StatefulWidget {
  const CustomerHomescreen({super.key});

  @override
  State<CustomerHomescreen> createState() => _CustomerHomescreenState();
}

class _CustomerHomescreenState extends State<CustomerHomescreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
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
          // actions: [
          //   GestureDetector(
          //     onTap: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => const Notifications()));
          //     },
          //     child: Padding(
          //       padding: const EdgeInsets.all(10.0),
          //       child: Image.asset(
          //         'images/notification.png',
          //         height: 25,
          //         width: 25,
          //       ),
          //     ),
          //   )
          // ],
        ),
        drawer: const CustomerSideMenu(),
        key: scaffoldKey,
        body: Container(
            margin: const EdgeInsets.only(right: 20, left: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                child: const CustomText(
                  text: "Your Reviews",
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  textcolor: kblackColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TabBar(
                  unselectedLabelColor: kGreyColor,
                  labelColor: kblackColor,
                  labelStyle: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                    color: kblackColor,
                    fontFamily: 'poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  )),
                  controller: tabController,
                  indicatorColor: kblackColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 2,
                  dividerColor: kblackColor,
                  tabs: const [
                    // Tab(
                    //   text: 'Recent',
                    // ),
                    // Tab(
                    //   text: 'Last Week',
                    // ),
                    // Tab(
                    //   text: 'Older',
                    // ),
                    Tab(
                      text: 'Requested',
                    ),
                    Tab(
                      text: 'Reviewed',
                    ),
                  ]),
              Expanded(
                  child: TabBarView(controller: tabController, children: const [
                // Recenttab(),
                // Lastweektab(),
                // Oldertab(),
                RequestedReviews(),
                Reviewedtab(),
              ]))
            ])));
  }
}
