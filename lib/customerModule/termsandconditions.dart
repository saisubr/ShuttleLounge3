import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shuttleloungenew/const/color.dart';
import 'package:shuttleloungenew/widgets/customtext.dart';


class TermsandConditions extends StatelessWidget {
  const TermsandConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhiteColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: kwhiteColor,
        title: const CustomText(
            text: "Terms & Conditions",
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
                  text: "Terms & Conditions ",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  textcolor: kblackColor),
              const SizedBox(
                height: 10,
              ),
              Text(
                "These Terms of Use apply to your use of the Shuttle mobile application  which is owned by Shuttle , a registered enterprise under the MSMED Act 2006 .. ",
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
                  text: "1) Accepting these Terms of Use",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  textcolor: kblackColor),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Our Service, including all the information and tools from Shuttle is conditioned upon your acceptance of all the terms, conditions and policies stated hereafter. By using our app, you agree to these Terms of Use and all applicable laws, rules and regulations. If you do not agree to these Terms of Use, you may not use the Service or any part thereof.",
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
                  text: "2) Changes and Amendments to Terms of Use",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  textcolor: kblackColor),
              const SizedBox(
                height: 10,
              ),
              Text(
                "We solely reserve the right to amend, add or delete portions of these Terms of Use at any given point in time. You are solely responsible for reviewing these Terms of Use from time to time to ensure that you are aware of any changes. Your usage of our services means that you also agree to condition of amendments of our terms & condition from time to time. ",
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
                  text: "3) Limitation on Use",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  textcolor: kblackColor),
              const SizedBox(
                height: 10,
              ),
              Text(
                "You hereby declare to the Company that you are at least fourteen (14) years of age or above and are capable abiding by these Terms and conditions. While individuals under the age of 14 may utilize our Service, they shall do so only under parental guidance from the registered account of their parents. You also agree to registering to the website prior to uploading any comment, content or profile picture and any other use or services of this site and provide your details including but not limited to full name, age, gender, email address, address, phone number etc. ",
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
                  text: "4) Intellectual Property Rights",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  textcolor: kblackColor),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Unless stated otherwise herein, we reserve all rights to any and all intellectual property in the Service, including but not limited to trademarks, logos, copyrighted works, ideas, app designs, trade secrets, software and any other intellectual property on the website, app or our social media accounts",
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
                  text: "5) Jurisdiction",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  textcolor: kblackColor),
              const SizedBox(
                height: 10,
              ),
              Text(
                "By using the Service you agree to apply and to govern the India law and no other law over your relationship and disputes with us, and to give the Indian court sole jurisdiction over any disputes between you and us.",
                style: GoogleFonts.poppins(
                  color: kblackColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.8,
                ),
                maxLines: null,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
