import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shuttleloungenew/const/color.dart';
import 'package:shuttleloungenew/expertmodule/expert_dashboard.dart';
import 'package:shuttleloungenew/sharedPreferences/sharedprefservices.dart';
import 'package:shuttleloungenew/widgets/custom_button.dart';
import 'package:shuttleloungenew/widgets/customtext.dart';
import 'package:shuttleloungenew/widgets/progressbar.dart';


class ExpertLogin extends StatefulWidget {
  const ExpertLogin({super.key});

  @override
  State<ExpertLogin> createState() => _ExpertLoginState();
}

class _ExpertLoginState extends State<ExpertLogin> {
  void _login() {
    if (_formKey.currentState!.validate()) {}
  }

  bool _isLoading = false;
  final emailController =
      TextEditingController(text: kDebugMode ? "testexp@gmail.com" : "");

  final TextEditingController phoneController =
      TextEditingController(text: kDebugMode ? "8555005960" : "");
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
        appBar: AppBar(
          backgroundColor: kwhiteColor,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: kblackColor,
              )),
          centerTitle: true,
          title: const CustomText(
              text: "Expert Login",
              fontSize: 24,
              fontWeight: FontWeight.w500,
              textcolor: kblackColor),
        ),
        body: SafeArea(
          child: Stack(children: [
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(right: 15, left: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            const CustomText(
                                text: "Email Address",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                textcolor: kblackColor),
                            const SizedBox(
                              height: 10,
                            ),
                            textFeld(
                              hintText: "Email",
                              icon: Icons.email,
                              inputType: TextInputType.emailAddress,
                              maxLines: 1,
                              controller: emailController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter a Email";
                                } else if (!RegExp(r'\S+@\S+\.\S+')
                                    .hasMatch(value)) {
                                  return "Please Enter a Valid Email";
                                }
                                return null;
                              },
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
                                              color: kblackColor,
                                            ))
                                          : const Icon(
                                              Icons.visibility,
                                              color: kblackColor,
                                            )),
                                  hintText: "Password",
                                  prefixIcon: const Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(12, 12, 10, 15),
                                    child: Icon(
                                      Icons.lock,
                                      color: kblackColor,
                                      size: 22,
                                    ),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(12, 12, 10, 15),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: kgreyColor)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: kgreyColor)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: kgreyColor)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: kgreyColor)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomButton(
                              text: "Login",
                              onPressed: () {
                                _login();
                                checkExpertwithFirebase();
                              },
                              color: kgreyColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              textColor: kwhiteColor,
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
            if (_isLoading)
              Center(
                child: ProgressBarHUD(),
              ),
          ]),
        ));
  }

  void checkExpertwithFirebase() async {
    String ph = "+91${phoneController.text}";
    setState(() {
      _isLoading = true;
    });
    final CollectionReference collection =
        FirebaseFirestore.instance.collection('experts');
    await collection
        // .where("phoneNumber", isEqualTo: ph)
        .where("email",
            isEqualTo: emailController.text.toLowerCase().trim().toString())
        .where("password", isEqualTo: passwordController.text)
        .snapshots()
        .listen((data) {
      if (data.docs.isEmpty) {
        setState(() {
          _isLoading = false;
        });

        // showSnackBar(context, "Please check your credentials");
      } else {
        setState(() {
          SharedPrefServices.setfirstname(data.docs[0]['firstName']);
          SharedPrefServices.setlastname(data.docs[0]['lastName']);
          SharedPrefServices.setemail(data.docs[0]['email']);
          SharedPrefServices.setphonenumber(data.docs[0]['phoneNumber']);
          SharedPrefServices.setprofileimage(data.docs[0]['profilePic']);
          // SharedPrefServices.setcustomerId(data.docs[0]['customerId']);
          SharedPrefServices.setexpertId(data.docs[0]['expertId']);
          SharedPrefServices.setqualified(data.docs[0]['qualified']);
          SharedPrefServices.setroleCode(data.docs[0]['roleCode']);
          SharedPrefServices.setpassword(data.docs[0]['password']);
          SharedPrefServices.setdocumentId(data.docs[0].id);
          SharedPrefServices.setislogged(true);
          SharedPrefServices.setrememberme("true");
          SharedPrefServices.setroleCode("EXPERT");
        });
        // showSnackBar(context, "login successful");

        Timer(const Duration(seconds: 5), () {
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ExpertDashboard();
              },
            ),
          );
        });
      }
    });
  }

  Widget textFeld({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
    required FormFieldValidator validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: SizedBox(
        height: 70,
        width: double.infinity,
        child: TextFormField(
          cursorColor: kgreyColor,
          cursorWidth: 2,
          controller: controller,
          keyboardType: inputType,
          validator: validator,
          maxLines: maxLines,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(12, 12, 10, 15),
            prefixIcon: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 10, 15),
              child: Icon(
                icon,
                size: 22,
                color: kblackColor,
              ),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: kgreyColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: kgreyColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: kgreyColor)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: kgreyColor)),
            hintText: hintText,
            alignLabelWithHint: true,
          ),
        ),
      ),
    );
  }
}
