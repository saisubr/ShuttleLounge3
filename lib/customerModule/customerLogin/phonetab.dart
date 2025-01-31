import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:shuttleloungenew/const/color.dart';
import 'package:shuttleloungenew/customerModule/bottomNavigationBarScreens/dashboard.dart';
import 'package:shuttleloungenew/expertmodule/expert_login.dart';
import 'package:shuttleloungenew/registration/registrationScreen.dart';
import 'package:shuttleloungenew/sharedPreferences/sharedprefservices.dart';
import 'package:shuttleloungenew/utils/utils.dart';
import 'package:shuttleloungenew/widgets/custom_button.dart';
import 'package:shuttleloungenew/widgets/customtext.dart';
import 'package:shuttleloungenew/widgets/progressbar.dart';


class Phonetab extends StatefulWidget {
  const Phonetab({super.key});

  @override
  State<Phonetab> createState() => _PhonetabState();
}

class _PhonetabState extends State<Phonetab> {
  void _login() {
    if (_formKey.currentState!.validate()) {}
  }

  bool _isLoading = false;

  final TextEditingController phoneController =
      TextEditingController(text: kDebugMode ? "7569643560" : "");
  final TextEditingController passwordController =
      TextEditingController(text: kDebugMode ? "Test@123" : "");

  bool _isValidPassword(String password) {
    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{7,}$');
    return regex.hasMatch(password);
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool hidden = true;

  Country selectedCountry = Country(
      phoneCode: "91",
      countryCode: "IN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "India",
      example: "India",
      displayName: "India",
      displayNameNoCountryCode: "IN",
      e164Key: "");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhiteColor,
      body: Stack(children: [
        Container(
          // margin: const EdgeInsets.only(right: 10, left: 10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const CustomText(
                      text: "Phone Number",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      textcolor: kblackColor),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 70,
                    child: Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter a valid Phone Number";
                            } else if (!RegExp(
                                    r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
                                .hasMatch(value)) {
                              return "Please Enter a Valid Phone Number";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "Enter Phone Number",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 14),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      const BorderSide(color: kgreyColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      const BorderSide(color: kgreyColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      const BorderSide(color: kgreyColor)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide:
                                      const BorderSide(color: kgreyColor)),
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 12, 10, 15),
                                child: InkWell(
                                  onTap: () {
                                    showCountryPicker(
                                        context: context,
                                        countryListTheme:
                                            const CountryListThemeData(
                                                bottomSheetHeight: 600),
                                        onSelect: (value) {
                                          setState(() {
                                            selectedCountry = value;
                                          });
                                        });
                                  },
                                  child: CustomText(
                                      text:
                                          "${selectedCountry.flagEmoji}+${selectedCountry.phoneCode}",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      textcolor: kblackColor),
                                ),
                              ),
                              suffixIcon: phoneController.text.length > 9
                                  ? const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        radius: 8,
                                        backgroundColor: kGreenColor,
                                        child: Icon(
                                          Icons.done,
                                          color: kwhiteColor,
                                          size: 15,
                                        ),
                                      ),
                                    )
                                  : null),
                        )),
                      ],
                    ),
                  ),
                  const CustomText(
                      text: "Password",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      textcolor: kblackColor),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 70,
                    child: TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: hidden,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter a Password";
                        } else if (!_isValidPassword(value)) {
                          return "Password must be at least 7 characters, along special ,numeric , one Uppercase ";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidden = !hidden;
                              });
                            },
                            icon: hidden
                                ? (const Icon(
                                    Icons.visibility_off,
                                    color: kgreyColor,
                                  ))
                                : const Icon(Icons.visibility,
                                    color: kgreyColor)),
                        hintText: "Enter Password",
                        prefixIcon: const Padding(
                          padding: EdgeInsets.fromLTRB(12, 12, 10, 15),
                          child: Icon(
                            Icons.lock,
                            color: kgreyColor,
                            size: 22,
                          ),
                        ),
                        // contentPadding:const EdgeInsets.only(top: 10,left: 15),
                        contentPadding:
                            const EdgeInsets.fromLTRB(12, 12, 10, 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: kgreyColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: kgreyColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: kgreyColor)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: kgreyColor)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomButton(
                    text: "Login",
                    onPressed: () {
                      _login();
                      checkwithFirebase();
                      // sendPhoneNumber()
                    },
                    color: kgreyColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    textColor: kwhiteColor,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // const Row(
                  //   children: [
                  //     Expanded(child: Divider(color: Color(0xffC2C2C2))),
                  //     Padding(
                  //         padding: EdgeInsets.all(8.0),
                  //         child: CustomText(
                  //           text: "Sign in with google",
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w500,
                  //           textcolor: Color(0xFF000000),
                  //         )),
                  //     Expanded(child: Divider(color: Color(0xffC2C2C2))),
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // CustomButton(
                  //   text: "Google",
                  //   textColor: const Color(0xFF000000),
                  //   onPressed: () {},
                  //   color: const Color(0xFFF5F5F5),
                  //   fontSize: 16,
                  //   fontWeight: FontWeight.w500,
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),

                  Container(
                    color: kwhiteColor,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Row(
                        children: [
                          const CustomText(
                            text: "No registered yet ?",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            textcolor: kblackColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegistrationScreen(
                                            roleCode: "CUST",
                                          )));
                            },
                            child: const CustomText(
                                text: "Create an account",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                textcolor: kgreyColor),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  const Row(
                    children: [
                      Expanded(child: Divider(color: kgreyColor)),
                      Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CustomText(
                            text: "OR",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            textcolor: kblackColor,
                          )),
                      Expanded(child: Divider(color: kgreyColor)),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ExpertLogin()));
                    },
                    text: "Login as Expert",
                    textColor: kgreyColor,
                    color: kgreyColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  )
                ],
              ),
            ),
          ),
        ),
        if (_isLoading)
          Center(
            child: ProgressBarHUD(),
          ),
      ]),
    );
  }

  void checkwithFirebase() async {
    String ph = "+91${phoneController.text}";
    setState(() {
      _isLoading = true;
    });

    final CollectionReference collection =
        FirebaseFirestore.instance.collection('users');

    await collection
        .where("phoneNumber", isEqualTo: ph)
        .where("password", isEqualTo: passwordController.text)
        .snapshots()
        .listen((data) {
      if (data.docs.isEmpty) {
        setState(() {
          _isLoading = false;
        });

        showSnackBar(context, "Please check your credentials");
      } else {
        setState(() {
          SharedPrefServices.setfirstname(data.docs[0]['firstName']);
          SharedPrefServices.setlastname(data.docs[0]['lastName']);
          SharedPrefServices.setemail(data.docs[0]['email']);
          SharedPrefServices.setphonenumber(data.docs[0]['phoneNumber']);
          SharedPrefServices.setprofileimage(data.docs[0]['profilePic']);
          SharedPrefServices.setcustomerId(data.docs[0]['customerId']);
          SharedPrefServices.setdocumentId(data.docs[0].id);
        });

        // showSnackBar(context, "login successful");

        Timer(const Duration(seconds: 5), () {
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const Dashboard();
              },
            ),
          );
        });
      }
    });
  }
}
