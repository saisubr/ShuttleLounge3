import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shuttleloungenew/const/color.dart';
import 'package:shuttleloungenew/widgets/customtext.dart';


class PrivacyandPolicy extends StatelessWidget {
  const PrivacyandPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhiteColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: kwhiteColor,
        title: const CustomText(
            text: "Privacy Policy",
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
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.only(right: 15, left: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              const CustomText(
                  text: "Our Privacy Policy was last Updated on [07-09-2023]",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  textcolor: kblackColor),
              const SizedBox(
                height: 15,
              ),
              Text(
                "This Privacy Policy describes Our polices and procedure on the collection,use the disclosre of your information when you see the Service and tells You about Your privacy rights and how the law protects you . ",
                style: GoogleFonts.poppins(
                  color: kblackColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.8,
                ),
                maxLines: null,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "We use Your Personal data to provide and improve the service. By using the Service, You aggre to the collection and use of informmation according to the privacy policy.",
                style: GoogleFonts.poppins(
                  color: kblackColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.8,
                ),
                maxLines: null,
              ),
              const SizedBox(
                height: 15,
              ),
              const CustomText(
                  text: "1) The Information We Collect",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  textcolor: kblackColor),
              const SizedBox(
                height: 10,
              ),
              const CustomText(
                  text: "Information that you provide on our App :",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textcolor: kblackColor),
              const SizedBox(
                height: 10,
              ),
              // Text("0"),
              Container(
                margin: const EdgeInsets.only(left: 25),
                width: double.infinity,
                child: const Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: kblackColor,
                          size: 8,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                            text: "Name",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            textcolor: kblackColor),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: kblackColor,
                          size: 8,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                            text: "Email",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            textcolor: kblackColor),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: kblackColor,
                          size: 8,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                            text: "Mobile Number",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            textcolor: kblackColor),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: kblackColor,
                          size: 8,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                            text: "Qualification",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            textcolor: kblackColor),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Account Signup Information. When You create the account, we ask You to provide the signup information, such as Email, Firstname, Lastname,Phone, Qualification,Passwords,.",
                style: GoogleFonts.poppins(
                  color: kblackColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.8,
                ),
                maxLines: null,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Login information. We collect Login information if You are logging to our account with Authentication Data.",
                style: GoogleFonts.poppins(
                  color: kblackColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.8,
                ),
                maxLines: null,
              ),
              const SizedBox(
                height: 15,
              ),
              const CustomText(
                  text: "2) The Way We Use Your Information",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  textcolor: kblackColor),
              const SizedBox(
                height: 10,
              ),
              Text(
                "We may use the information we collect through our app for a number of reasons, including to .",
                style: GoogleFonts.poppins(
                  color: kblackColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.8,
                ),
                maxLines: null,
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.only(left: 25),
                width: double.infinity,
                child: const Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: kblackColor,
                          size: 8,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                            text: "to identify user",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            textcolor: kblackColor),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: kblackColor,
                          size: 8,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                            text: "to identify expert",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            textcolor: kblackColor),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: kblackColor,
                          size: 8,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                            text: "to create account",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            textcolor: kblackColor),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: kblackColor,
                          size: 8,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                            text: "to create trusted environment",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            textcolor: kblackColor),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: kblackColor,
                          size: 8,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                            text: "to know qualification",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            textcolor: kblackColor),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: kblackColor,
                          size: 8,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                            text: "to post video & review",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            textcolor: kblackColor),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: kblackColor,
                          size: 8,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                            text: "to get review from experts",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            textcolor: kblackColor),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: kblackColor,
                          size: 8,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                            text: "to improve services",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            textcolor: kblackColor),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: kblackColor,
                          size: 8,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                            text: "to provide support",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            textcolor: kblackColor),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomText(
                  text: "3) Security of Data You Share With Us ",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  textcolor: kblackColor),
              const SizedBox(
                height: 10,
              ),
              Text(
                "We implement appropriate security mechanisms that continuosly protect your information from  unauthorised access and disclosure. We limit access to personal information to those who need it in order to process it .",
                style: GoogleFonts.poppins(
                  color: kblackColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.8,
                ),
                maxLines: null,
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomText(
                  text: "4) Cookies",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  textcolor: kblackColor),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Cookies are small text files stored by your browser on your computer when you visit our Site. We use cookies to improve our Site and make it easier to use. Cookies permit us to recognize users and avoid repetitive requests for the same information.",
                style: GoogleFonts.poppins(
                  color: kblackColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.8,
                ),
                maxLines: null,
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomText(
                  text: "5) Change to This Policy",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  textcolor: kblackColor),
              const SizedBox(
                height: 10,
              ),
              Text(
                "We change this Privacy Policy whenever such a need arises. Your rights under this privacy policy will not be reduced without your explicit consent.",
                style: GoogleFonts.poppins(
                  color: kblackColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.8,
                ),
                maxLines: null,
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
