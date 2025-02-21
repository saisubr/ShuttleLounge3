import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shuttleloungenew/const/color.dart';
import 'package:shuttleloungenew/customerModule/customerLogin/emailtab.dart';
import 'package:shuttleloungenew/widgets/customtext.dart';


class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
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
      child: DefaultTabController(
          length: 1,
          child: Scaffold(
            backgroundColor: const Color(0xFFFFFFFF),
            body: SafeArea(
              child: Container(
                margin: const EdgeInsets.only(right: 10, left: 10),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    CustomText(
                        text: "User Login",
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        textcolor: Color(0xFF000000)),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Emailtab(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
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
