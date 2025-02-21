import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return PopScope(
        canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        bool exitApp = await _showExitDialog(context);
        if (exitApp) {
          Navigator.of(context).pop(true);
        }
      },
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


  Future<bool> _showExitDialog(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Text('Do you want to exit the app ?',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500)),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Cancel',
                    style: GoogleFonts.poppins(
                        color: kblackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  exit(0);
                },
                child: Text('Exit',
                    style: GoogleFonts.poppins(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        )) ??
        false;
  }

}
