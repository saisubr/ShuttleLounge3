import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shuttleloungenew/const/color.dart';

import 'package:shuttleloungenew/customerModule/customerHomescreen.dart';
import 'package:shuttleloungenew/customerModule/postReviewRequestScreen.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectIndex = index;
    });
  }

  List children = const [
    CustomerHomescreen(),
    PostReviewRequestScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
          backgroundColor: kwhiteColor,
          body: children[selectIndex],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 5,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            currentIndex: selectIndex,
            onTap: _onItemTapped,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: buildIcon(0, 'images/homeicon.png'),
                label: '',
              ),
              // BottomNavigationBarItem(
              //   icon: buildIcon(1, 'images/graphicon.png'),
              //   label: '',
              // ),
              BottomNavigationBarItem(
                icon: buildIcon(1, 'images/addicon.png'),
                label: '',
              ),
              // BottomNavigationBarItem(
              //   icon: buildIcon(2, 'images/calendericon.png'),
              //   label: '',
              // ),
              // BottomNavigationBarItem(
              //   icon: buildIcon(3, 'images/filtericon.png'),
              //   label: '',
              // ),
            ],
          )

          // PersistentTabView(
          //   context,
          //   controller: _controller,
          //   screens: [
          //     CustomerHomescreen(),
          //     PostReviewRequestScreen(),
          //   ],
          //   items: _navBarsItems(),
          //   navBarHeight: 70,
          //   navBarStyle: NavBarStyle.style2,
          // ),
          ),
    );
  }

  // List<PersistentBottomNavBarItem> _navBarsItems() {
  //   return [
  //     PersistentBottomNavBarItem(
  //       contentPadding: 0,
  //       icon: Icon(Icons.home_outlined),
  //       activeColorPrimary: kredColor,
  //       inactiveColorPrimary: kgreyColor,
  //     ),
  //     PersistentBottomNavBarItem(
  //       contentPadding: 0,
  //       icon: Icon(Icons.add),
  //       activeColorPrimary: kredColor,
  //       inactiveColorPrimary: kgreyColor,
  //     ),
  //   ];
  // }

  Widget buildIcon(int index, String imagePath) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: selectIndex == index ? Colors.black : kTransparent,
        child: Image.asset(
          imagePath,
          width: 25,
          height: 25,
          color: selectIndex == index ? Colors.white : Colors.black,
        ),
      ),
    );
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
