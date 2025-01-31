import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:shuttleloungenew/const/color.dart';
import 'package:shuttleloungenew/customerModule/bottomNavigationBarScreens/dashboard.dart';
import 'package:shuttleloungenew/expertmodule/expert_dashboard.dart';
import 'package:shuttleloungenew/models/user_model.dart';
import 'package:shuttleloungenew/providers/auth_provider.dart';
import 'package:shuttleloungenew/sharedPreferences/sharedprefservices.dart';
import 'package:shuttleloungenew/utils/utils.dart';
import 'package:shuttleloungenew/widgets/custom_button.dart';
import 'package:shuttleloungenew/widgets/customtext.dart';


class Otp_screen extends StatefulWidget {
  final String verificationId;
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String phoneNumber;
  final String roleCode;
  final String qualified;
  final File image;
  const Otp_screen(
      {super.key,
      required this.verificationId,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.password,
      required this.phoneNumber,
      required this.roleCode,
      required this.image,
      required this.qualified});

  @override
  State<Otp_screen> createState() => _Otp_screenState();
}

class _Otp_screenState extends State<Otp_screen> {
  String? otpCode;
  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;

    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: kgreyColor,
                ),
              )
            : Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Text(
                      //   widget.email +
                      //       widget.firstName +
                      //       widget.lastName +
                      //       widget.phoneNumber +
                      //       widget.roleCode +
                      //       widget.qualified,
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     color: Colors.black38,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      //   textAlign: TextAlign.center,
                      // ),
                      const Text(
                        "Verification",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Enter the OTP send to your phone number",
                        style: TextStyle(
                          fontSize: 14,
                          color: kblackColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Pinput(
                        length: 6,
                        showCursor: true,
                        defaultPinTheme: PinTheme(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: kgreyColor,
                            ),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onCompleted: (value) {
                          setState(() {
                            otpCode = value;
                          });
                        },
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: CustomButton(
                          text: "Verify",
                          onPressed: () {
                            if (otpCode != null) {
                              verifyOtp(context, otpCode!);
                            } else {
                              showSnackBar(context, "Enter 6-Digit code");
                            }
                          },
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: kgreyColor,
                          textColor: kwhiteColor,
                        ),
                        // CustomButton(
                        //   text: "Verify",
                        //   onPressed: () {
                        //     if (otpCode != null) {
                        //       verifyOtp(context, otpCode!);
                        //     } else {
                        //       showSnackBar(context, "Enter 6-Digit code");
                        //     }
                        //   },
                        // ),
                      ),
                      const SizedBox(height: 20),
                      const CustomText(
                        text: "Didn't receive any code?",
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        textcolor: kblackColor,
                      ),
                      const SizedBox(height: 15),
                      const CustomText(
                        text: "Resend New Code",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        textcolor: kgreyColor,
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        // checking whether user exists in the db
        ap.checkExistingUser(widget.roleCode).then(
          (value) async {
            if (value == true) {
              // user exists in our app
              ap.getDataFromFirestore().then(
                    (value) => ap.saveUserDataToSP().then(
                          (value) => ap.setSignIn().then((value) =>
                              showSnackBar(context,
                                  "Account already exists. Please LOGIN")),
                        ),
                  );
            } else {
              storeData();
            }
          },
        );
      },
    );
  }

//  store user data to database
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      roleCode: widget.roleCode,
      firstName: widget.firstName,
      lastName: widget.lastName,
      email: widget.email,
      password: widget.password,
      profilePic: "",
      createdAt: "",
      phoneNumber: widget.phoneNumber,
      customerId: "${widget.phoneNumber}1234",
    );
    // ExpertModel expertModel = ExpertModel(
    //   roleCode: widget.roleCode,
    //   firstName: widget.firstName,
    //   lastName: widget.lastName,
    //   email: widget.email,
    //   password: widget.password,
    //   profilePic: "",
    //   createdAt: "",
    //   phoneNumber: widget.phoneNumber,
    //   qualified: SharedPrefServices.getqualified().toString(),
    //   expertId: "${widget.phoneNumber}1234",
    // );

    ap.saveUserDataToFirebase(
      context: context,
      userModel: userModel,
      roleCode: widget.roleCode,
      // profilePic: widget.image,
      qualified: SharedPrefServices.getqualified().toString(),
      onSuccess: () {
        // ap.saveUserDataToSP().then(
        //       (value) =>
        ap.setSignIn().then((value) {
          SharedPrefServices.setfirstname(widget.firstName);
          SharedPrefServices.setlastname(widget.lastName);
          SharedPrefServices.setemail(widget.email);
          SharedPrefServices.setphonenumber(widget.phoneNumber);
          SharedPrefServices.setcustomerId(widget.phoneNumber);
          SharedPrefServices.setroleCode(widget.roleCode);
          SharedPrefServices.setqualified(widget.qualified);
          // SharedPrefServices.setprofileimage(widget.image);
          // SharedPrefServices.setcustomerId(widget.customerId);

          Timer(const Duration(seconds: 5), () {
            if (widget.roleCode == "CUST") {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const Dashboard();
                  },
                ),
              );
            } else if (widget.roleCode == "EXPERT") {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const ExpertDashboard();
                  },
                ),
              );
            }
          });
        });
        // );
      },
    );
  }
}
