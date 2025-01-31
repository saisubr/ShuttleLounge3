import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shuttleloungenew/const/color.dart';
import 'package:shuttleloungenew/expertmodule/expertStatistics/expert_statisticsScreen.dart';
import 'package:shuttleloungenew/expertmodule/expert_profile.dart';
import 'package:shuttleloungenew/expertmodule/expert_sidemenu.dart';
import 'package:shuttleloungenew/expertmodule/expertreviewstabs/expert_reviews.dart';
import 'package:shuttleloungenew/sharedPreferences/sharedprefservices.dart';
import 'package:shuttleloungenew/widgets/customtext.dart';


class ExpertDashboard extends StatefulWidget {
  const ExpertDashboard({super.key});

  @override
  State<ExpertDashboard> createState() => _ExpertDashboardState();
}

class _ExpertDashboardState extends State<ExpertDashboard> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  int selectIndex = 0;
  List<String> dayNames = [];
  List<String> datesList = [];
  List countList = [];
  List viewBar = [0, 0, 0, 0, 0, 0, 0];

  void _onItemTapped(int index) {
    setState(() {
      selectIndex = index;
    });
  }

  @override
  void initState() {
    generateDates();
    dayNames = getDayNames();
    getReviewCounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List children = [
      const ExpertReviews(),
      ExpertStatistics(dayNames: dayNames, viewBar: viewBar),
      const ExpertProfile(),
    ];
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
          backgroundColor: kwhiteColor,
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: kwhiteColor,
            elevation: 0,
            titleSpacing: 5,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    scaffoldKey.currentState!.openDrawer();
                  },
                  child: CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(
                      SharedPrefServices.getprofileimage().toString(),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Image(
                    image: AssetImage("images/pro.png"), height: 45, width: 45),
                const Expanded(
                  child: Center(
                      child: CustomText(
                          text: "Shuttle Lounge",
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          textcolor: kblackColor)),
                )
              ],
            ),
            automaticallyImplyLeading: false,
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  'images/notification.png',
                  height: 25,
                  width: 25,
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
          drawer: const ExpertSideMenu(),
          body: children[selectIndex],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 5,
            type: BottomNavigationBarType.fixed,
            backgroundColor: kwhiteColor,
            selectedItemColor: kblackColor,
            unselectedItemColor: kgreyColor,
            currentIndex: selectIndex,
            onTap: _onItemTapped,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: buildIcon(
                  0,
                  Icons.home,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: buildIcon(1, Icons.auto_graph),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: buildIcon(
                  2,
                  Icons.person,
                ),
                label: '',
              ),
            ],
          )),
    );
  }

  Widget buildIcon(int index, IconData iconData) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: selectIndex == index ? kblackColor : kTransparent,
        child: Icon(
          iconData,
          size: 25,
          color: selectIndex == index ? kwhiteColor : kblackColor,
        ),
      ),
    );
  }

  void generateDates() {
    // start progress
    // setState(() {
    //   _isLoading = true;
    // });
    DateTime currentDate = DateTime.now();
    for (int i = 0; i < 7; i++) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(currentDate);
      currentDate = currentDate.subtract(const Duration(days: 1));
      datesList.insert(0, formattedDate);
    }
    print('Now Priniting Dates');
    print(datesList);
    getReviewCounts();
  }

  List<String> getDayNames() {
    DateTime now = DateTime.now();
    List<String> days = ['M', 'T', 'W', 'TH', 'F', 'S', 'SU'];
    int currentDayIndex = now.weekday;

    List<String> dayNames = [];

    for (int i = currentDayIndex; i < days.length; i++) {
      dayNames.add(days[i]);
    }

    for (int i = 0; i < currentDayIndex; i++) {
      dayNames.add(days[i]);
    }
    return dayNames;
  }

  Future<List<Map<String, dynamic>>> getReviewCounts() async {
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection('reviewCounts')
          .where('expertId', isEqualTo: SharedPrefServices.getexpertId())
          .get();

      List<Map<String, dynamic>> reviewCount = querySnapshot.docs.map((doc) {
        return {
          'date': doc['date'],
          'expertId': doc['expertId'],
          'reviewDocId': doc['reviewDocId'],
        };
      }).toList();

      countList = List<int>.filled(datesList.length, 0);

      for (var count in reviewCount) {
        String date = count['date'];
        int index = datesList.indexOf(date);
        if (index != -1) {
          countList[index]++;
        }
      }
      print('Dashboard Printing Counts:');
      print(countList);
      viewBar.clear();

      setState(() {
        viewBar = countList;
      });

      print('Dashboard Printing Data:');
      print(reviewCount);

      // setState(() {
      //   _isLoading = false;
      // });
      // stop progress
      return reviewCount;
    } catch (error) {
      print("Error fetching reviewsCounts : $error");
      return [];
    }
  }

  showExitPopup(BuildContext context) {
    Future<bool> showExitPopup(context) async {
      return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                height: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Image.asset(
                    //     'images/app_icon.png',
                    //     scale: 1.5,
                    //   ),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Are you sure you want to exit app ?",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        // fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            print('no selected');
                            Navigator.of(context).pop();
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Color(0xFFFF6700)),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Color(0xffFF6700),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            print('yes selected');
                            exit(0);
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                color: Color(0xFFFF6700),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      "Exit",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          });
    }
  }
}
