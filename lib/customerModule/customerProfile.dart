import 'package:flutter/material.dart';
import 'package:shuttleloungenew/const/color.dart';
import 'package:shuttleloungenew/customerModule/changeCustomerpassword.dart';
import 'package:shuttleloungenew/customerModule/customerEditProfile.dart';
import 'package:shuttleloungenew/sharedPreferences/sharedprefservices.dart';
import 'package:shuttleloungenew/widgets/customtext.dart';


class CustomerProfilescreen extends StatelessWidget {
  const CustomerProfilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kwhiteColor,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: kwhiteColor,
          title: const CustomText(
              text: "My Profile",
              fontSize: 20,
              fontWeight: FontWeight.w600,
              textcolor: kblackColor),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: kblackColor,
              size: 22,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 75.0,
                        backgroundColor: kwhiteColor,
                        backgroundImage: NetworkImage(
                          SharedPrefServices.getprofileimage().toString(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                  margin:
                      const EdgeInsets.only(left: 15.0, right: 15.0, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 4.0,
                      ),
                      const CustomText(
                          text: "Full Name",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          textcolor: kblackColor),
                      const SizedBox(
                        height: 4.0,
                      ),

                      CustomViewText(
                          geticon: Icons.person,
                          text:
                              "${SharedPrefServices.getfirstname()} ${SharedPrefServices.getlastname()}"),

                      const SizedBox(
                        height: 10.0,
                      ),

                      const CustomText(
                          text: "Email",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          textcolor: kblackColor),
                      const SizedBox(
                        height: 5.0,
                      ),
                      CustomViewText(
                          geticon: Icons.mail,
                          text: SharedPrefServices.getemail().toString()),

                      const SizedBox(
                        height: 10.0,
                      ),
                      // const CustomText(
                      //     text: "Mobile Number",
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w500,
                      //     textcolor: kgreyColor),
                      // const SizedBox(
                      //   height: 5.0,
                      // ),
                      // Row(
                      //   children: [
                      //     const Icon(
                      //       Icons.phone,
                      //       color: kgreyColor,
                      //       size: 20,
                      //     ),
                      //     const SizedBox(
                      //       width: 10,
                      //     ),
                      //     CustomText(
                      //         text: SharedPrefServices.getphonenumber()
                      //             .toString(),
                      //         fontSize: 14,
                      //         fontWeight: FontWeight.w400,
                      //         textcolor: kblackColor),
                      // ],
                      // ),
                      // const SizedBox(
                      //   height: 5.0,
                      // ),
                      // const Divider(
                      //   height: 2.0,
                      //   thickness: 1.0,
                      // ),
                      // const SizedBox(
                      //   height: 10.0,
                      // ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 45,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CustomerEditProfile()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      backgroundColor: kgreyColor,
                                      fixedSize: const Size(358, 48),
                                      textStyle: const TextStyle(
                                        fontSize: 14.0,
                                        color: kwhiteColor,
                                        fontFamily: 'Poppins-regular',
                                        fontWeight: FontWeight.w700,
                                      )),
                                  child: const CustomText(
                                      text: "EDIT PROFILE",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      textcolor: kwhiteColor)),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            SizedBox(
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () async {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return const ChangecustomerPassword();
                                      },
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    side: const BorderSide(
                                        width: 1, // thickness
                                        color: kgreyColor),
                                    backgroundColor: kwhiteColor,
                                    fixedSize: const Size(358, 48),
                                    textStyle: const TextStyle(
                                      fontSize: 14.0,
                                      color: kwhiteColor,
                                      fontFamily: 'Poppins-regular',
                                      fontWeight: FontWeight.w700,
                                    )),
                                child: const CustomText(
                                    text: "CHANGE PASSWORD",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    textcolor: kblackColor),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
