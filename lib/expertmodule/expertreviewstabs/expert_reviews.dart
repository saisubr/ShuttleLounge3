import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shuttleloungenew/const/color.dart';
import 'package:shuttleloungenew/expertmodule/expertreviewstabs/expertbluelist.dart';
import 'package:shuttleloungenew/expertmodule/expertreviewstabs/expertgreenlist.dart';
import 'package:shuttleloungenew/expertmodule/expertreviewstabs/expertgreylist.dart';
import 'package:shuttleloungenew/widgets/customtext.dart';


class ExpertReviews extends StatefulWidget {
  const ExpertReviews({super.key});

  @override
  State<ExpertReviews> createState() => _ExpertReviewsState();
}

class _ExpertReviewsState extends State<ExpertReviews>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return Scaffold(
        backgroundColor: kwhiteColor,
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
                  dividerColor: kTransparent,
                  tabs: const [
                    Tab(
                      text: 'Requests',
                    ),
                    Tab(
                      text: 'Todo',
                    ),
                    Tab(
                      text: 'Done',
                    )
                  ]),
              Expanded(
                  child: TabBarView(controller: tabController, children: const [
                ReviewsList(),
                Mylist(),
                ExpertAnswer(),
              ]))
            ])));
  }
}
