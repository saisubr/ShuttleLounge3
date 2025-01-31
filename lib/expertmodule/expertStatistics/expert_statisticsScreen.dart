import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shuttleloungenew/const/color.dart';
import 'package:shuttleloungenew/widgets/customtext.dart';
import 'package:shuttleloungenew/widgets/progressbar.dart';
import 'package:shuttleloungenew/widgets/verticalbars.dart';

// import 'package:vertical_percent_indicator/vertical_percent_indicator.dart';
import '../../sharedPreferences/sharedprefservices.dart';

class ExpertStatistics extends StatefulWidget {
  List dayNames, viewBar;
  ExpertStatistics({super.key, required this.dayNames, required this.viewBar});

  @override
  State<ExpertStatistics> createState() => _ExpertStatisticsState();
}

class _ExpertStatisticsState extends State<ExpertStatistics> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  bool _isLoading = false;

  int pendingReviews = 0;
  int queueReviews = 0;
  int givenReviews = 0;

  @override
  void initState() {
    fetchPendingReviewsCount();
    fetchGivenReviewsCount();
    fetchQueueReviewsCount();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhiteColor,
      body: Stack(children: [
        Container(
          margin: const EdgeInsets.only(right: 10, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.center,
                child: const CustomText(
                  text: "Activity",
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  textcolor: kblackColor,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              //  BarChartSample(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  7,
                  (index) => Verticalbars(
                    height: 150,
                    width: 5,
                    percent: widget.viewBar.isEmpty
                        ? 0.0
                        : widget.viewBar[index] / 10,
                    // widget.this.v.isEmpty ? 0.0 : viewBar[index] / 10,
                    header:
                        '${widget.viewBar.isEmpty ? 0 : widget.viewBar[index]}',
                    footer: widget.dayNames[index],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                margin: const EdgeInsets.only(right: 15, left: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "images/requesticon.png",
                          height: 42,
                          width: 35,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                                text: "Total Requests",
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                textcolor: kblackColor),
                            CustomText(
                                text: "$pendingReviews  Reviews",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                textcolor: kGreyColor),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      children: [
                        Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: HexColor("#F75858")),
                            child: Center(
                                child: Image.asset(
                              "images/receviedicon.png",
                              height: 30,
                              width: 30,
                            ))),
                        const SizedBox(
                          width: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                                text: "Reviews Pending",
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                textcolor: kblackColor),
                            CustomText(
                                text: "$queueReviews pending",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                textcolor: kGreyColor),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      children: [
                        Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: HexColor("#2BAEF7")),
                            child: Center(
                                child: Image.asset(
                              "images/reviewsicon.png",
                              height: 30,
                              width: 30,
                            ))),
                        const SizedBox(
                          width: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                                text: "Reviewed",
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                textcolor: kblackColor),
                            CustomText(
                                text: "$givenReviews reviewed",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                textcolor: kGreyColor),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        if (_isLoading)
          Center(
            child: ProgressBarHUD(),
          ),
      ]),
    );
  }

  fetchPendingReviewsCount() async {
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection('requestedReviews')
          .where('expert_queue_Id', isEqualTo: '')
          .where("is_Answered", isEqualTo: "FALSE")
          .orderBy('timestamp', descending: true)
          .get();
      setState(() {
        pendingReviews = querySnapshot.docs.length;
      });
      print(querySnapshot.docs.length);
      return [];
    } catch (error) {
      print("Error fetching video details: $error");
      return [];
    }
  }

  fetchQueueReviewsCount() async {
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection('requestedReviews')
          .where('expert_queue_Id', isEqualTo: SharedPrefServices.getexpertId())
          .where("is_Answered", isEqualTo: "HOLD")
          .orderBy('timestamp', descending: true)
          .get();
      setState(() {
        queueReviews = querySnapshot.docs.length;
      });
      print(querySnapshot.docs.length);
      return [];
    } catch (error) {
      print("Error fetching video details: $error");
      return [];
    }
  }

  fetchGivenReviewsCount() async {
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection('requestedReviews')
          .where('expert_queue_Id', isEqualTo: SharedPrefServices.getexpertId())
          .where("is_Answered", isEqualTo: "TRUE")
          .orderBy('timestamp', descending: true)
          .get();
      setState(() {
        givenReviews = querySnapshot.docs.length;
      });

      print(querySnapshot.docs.length);
      return [];
    } catch (error) {
      print("Error fetching video details: $error");
      return [];
    }
  }
}
