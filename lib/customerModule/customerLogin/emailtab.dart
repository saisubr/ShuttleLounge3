import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shuttleloungenew/const/color.dart';
import 'package:shuttleloungenew/customerModule/bottomNavigationBarScreens/dashboard.dart';
import 'package:shuttleloungenew/expertmodule/expert_login.dart';
import 'package:shuttleloungenew/registration/registrationScreen.dart';
import 'package:shuttleloungenew/sharedPreferences/sharedprefservices.dart';
import 'package:shuttleloungenew/widgets/custom_button.dart';
import 'package:shuttleloungenew/widgets/customtext.dart';
import 'package:shuttleloungenew/widgets/progressbar.dart';

class Emailtab extends StatefulWidget {
  const Emailtab({super.key});

  @override
  State<Emailtab> createState() => _EmailtabState();
}

class _EmailtabState extends State<Emailtab> {
  final TextEditingController emailController = TextEditingController(
      text: kDebugMode ? "chollettiudayteja@gmail.com" : "");
  final TextEditingController passwordController =
      TextEditingController(text: kDebugMode ? "Test@123" : "");

  bool _isValidPassword(String password) {
    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{7,}$');
    return regex.hasMatch(password);
  }

  void _showTerms() {
    _launchUrl('https://www.shuttlelounge.com/terms-and-condition.html');
  }

  void _showPrivacy() {
    _launchUrl('https://www.shuttlelounge.com/privacy-policy.html');
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        // fallback to dialog if cannot launch
        _showUnableToOpen();
      }
    } catch (e) {
      _showUnableToOpen();
    }
  }

  void _showUnableToOpen() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Unable to open'),
            content:
                const Text('Could not open the link. Please try again later.'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'))
            ],
          );
        });
  }

  bool password = true;

  bool _isLoading = false;

  bool _acceptedTerms = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhiteColor,
      body: Stack(children: [
        Container(
          margin: const EdgeInsets.only(right: 10, left: 10),
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
                      text: "Email",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      textcolor: kblackColor),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 70,
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textAlignVertical: TextAlignVertical.center,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter a Email";
                        } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return "Please Enter a Valid Email";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: const Padding(
                          padding: EdgeInsets.fromLTRB(12, 12, 10, 15),
                          child: Icon(
                            Icons.email,
                            color: kblackColor,
                            size: 22,
                          ),
                        ),

                        //  contentPadding: const EdgeInsets.fromLTRB(15, 25, 15, 10),
                        contentPadding:
                            const EdgeInsets.fromLTRB(12, 12, 10, 15),

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
                      ),
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
                      obscureText: password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter a Password";
                        } else if (!_isValidPassword(value)) {
                          return "Password must be at least 7 characters, along special ,numeric";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                password = !password;
                              });
                            },
                            icon: password
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
                          padding: EdgeInsets.fromLTRB(12, 12, 10, 15),
                          child: Icon(
                            Icons.lock,
                            color: kblackColor,
                            size: 22,
                          ),
                        ),
                        //  contentPadding: const EdgeInsets.fromLTRB(15, 25, 15, 10),
                        contentPadding:
                            const EdgeInsets.fromLTRB(12, 12, 10, 15),
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
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: _acceptedTerms,
                          onChanged: (val) {
                            setState(() {
                              _acceptedTerms = val ?? false;
                            });
                          },
                        ),
                        Expanded(
                          child: Wrap(
                            children: [
                              const Text('I agree to the '),
                              GestureDetector(
                                onTap: () => _showTerms(),
                                child: const Text(
                                  'Terms & Conditions',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: kgreyColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              const Text(' and '),
                              GestureDetector(
                                onTap: () => _showPrivacy(),
                                child: const Text(
                                  'Privacy Policy',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: kgreyColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomButton(
                    text: "Login",
                    onPressed: () {
                      if (!_acceptedTerms) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Please accept Terms & Conditions and Privacy Policy')),
                        );
                        return;
                      }
                      if (_formKey.currentState!.validate()) {
                        checkwithFirebase();
                      }
                    },
                    color: kgreyColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    textColor: kwhiteColor,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    color: kwhiteColor,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2, left: 2),
                      child: Row(
                        children: [
                          const CustomText(
                              text: "No registered yet ?",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              textcolor: kblackColor),
                          const SizedBox(
                            width: 3,
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
                          ),
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
                    textColor: kwhiteColor,
                    color: kgreyColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
    // start progress bar
    setState(() {
      _isLoading = true;
    });

    final CollectionReference collection =
        FirebaseFirestore.instance.collection('users');

    await collection
        .where("email", isEqualTo: emailController.text)
        .where("password", isEqualTo: passwordController.text)
        .snapshots()
        .listen((data) {
      if (data.docs.isEmpty) {
        // stop progress bar
        setState(() {
          _isLoading = false;
        });

        // showSnackBar(context, "Please check your credentials");
      } else {
        print(data.docs[0]['firstName']);
        setState(() {
          SharedPrefServices.setfirstname(data.docs[0]['firstName']);
          SharedPrefServices.setlastname(data.docs[0]['lastName']);
          SharedPrefServices.setemail(data.docs[0]['email']);
          SharedPrefServices.setphonenumber(data.docs[0]['phoneNumber']);
          SharedPrefServices.setprofileimage(data.docs[0]['profilePic']);
          SharedPrefServices.setcustomerId(data.docs[0]['customerId']);
          SharedPrefServices.setpassword(data.docs[0]['password']);
          SharedPrefServices.setdocumentId(data.docs[0].id);
          SharedPrefServices.setislogged(true);
          SharedPrefServices.setrememberme("true");
          SharedPrefServices.setroleCode("CUST");
        });

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
