import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shuttleloungenew/const/color.dart';
import 'package:shuttleloungenew/customerModule/customerLogin/loginscreen.dart';
import 'package:shuttleloungenew/expertmodule/changeExpertpassword.dart';
import 'package:shuttleloungenew/expertmodule/expert_privacy.dart';
import 'package:shuttleloungenew/expertmodule/expert_termscondition.dart';
import 'package:shuttleloungenew/providers/auth_provider.dart';
import 'package:shuttleloungenew/sharedPreferences/sharedprefservices.dart';
import 'package:shuttleloungenew/widgets/customtext.dart';

class ExpertSideMenu extends StatelessWidget {
  const ExpertSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: kgreyColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 60.0,
                      height: 60.0,
                      child: CircleAvatar(
                        radius: 55.0,
                        backgroundColor: kTransparent,
                        backgroundImage: NetworkImage(
                          SharedPrefServices.getprofileimage().toString(),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                      color: kwhiteColor,
                      iconSize: 25,
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Hello ${SharedPrefServices.getfirstname()}",
                  style: const TextStyle(color: kwhiteColor, fontSize: 16),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "${SharedPrefServices.getemail()}",
                  style: const TextStyle(color: kwhiteColor, fontSize: 16),
                ),
              ],
            ),
          ),
          ListTile(
              leading: const Icon(
                Icons.password,
                color: kblackColor,
                size: 25,
              ),
              title: const CustomText(
                  text: "Change Password",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  textcolor: kblackColor),
              onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChangeExpertPassword()))
                  }),
          // ListTile(
          //   leading: const Icon(
          //     Icons.settings,
          //     color: kblackColor,
          //     size: 25,
          //   ),
          //   title: const CustomText(
          //       text: "Terms and Conditions",
          //       fontSize: 16,
          //       fontWeight: FontWeight.w500,
          //       textcolor: kblackColor),
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => const ExpertTermsConditions()));
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.privacy_tip,
          //     color: kblackColor,
          //     size: 25,
          //   ),
          //   title: const CustomText(
          //       text: "Privacy and Policy",
          //       fontSize: 16,
          //       fontWeight: FontWeight.w500,
          //       textcolor: kblackColor),
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => const ExpertPrivacy()));
          //   },
          // ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    title: const Center(
                        child: CustomText(
                            text: 'Are you sure want to logout ?',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            textcolor: kblackColor)),
                    // content: const Padding(
                    //   padding: EdgeInsets.only(
                    //     left: 15,
                    //   ),
                    //   child: CustomText(
                    //       text: ' Are you sure want to logout ?',
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.w500,
                    //       textcolor: kblackColor),
                    // ),
                    actions: [
                      Container(
                        margin: const EdgeInsets.only(right: 10, left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: 100,
                                child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            color: kgreyColor)),
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(color: kgreyColor),
                                    ))),
                            SizedBox(
                                width: 100,
                                child: ElevatedButton(
                                    onPressed: () {
                                      SharedPrefServices
                                          .clearUserFromSharedPrefs();
                                      ap.userSignOut().then(
                                            (value) => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const Loginscreen(),
                                              ),
                                            ),
                                          );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: kgreyColor),
                                    child: const Text(
                                      "Logout",
                                      style: TextStyle(color: Colors.white),
                                    )))
                          ],
                        ),
                      )
                    ],
                  );
                },
              );
            },
            child: const ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: kblackColor,
                size: 25,
              ),
              title: CustomText(
                  text: "Logout",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  textcolor: kblackColor),
            ),
          ),
        ],
      ),
    );
  }
}
