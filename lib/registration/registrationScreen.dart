import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shuttleloungenew/const/color.dart';
import 'package:shuttleloungenew/customerModule/bottomNavigationBarScreens/dashboard.dart';
import 'package:shuttleloungenew/models/user_model.dart';
import 'package:shuttleloungenew/providers/auth_provider.dart';
import 'package:shuttleloungenew/sharedPreferences/sharedprefservices.dart';
import 'package:shuttleloungenew/utils/utils.dart';
import 'package:shuttleloungenew/widgets/custom_button.dart';
import 'package:shuttleloungenew/widgets/customtext.dart';


class RegistrationScreen extends StatefulWidget {
  String roleCode;
  RegistrationScreen({
    required this.roleCode,
  });

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _isValidPassword(String password) {
    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{7,}$');
    return regex.hasMatch(password);
  }

  _validation() async {
    if (_formKey.currentState!.validate()) {
      await sendPhoneNumber();
    }
  }

  void noImageSelect() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please pick your image'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  bool password = true;

  bool ispassword = true;

  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Country selectedCountry = Country(
      phoneCode: "44",
      countryCode: "GB",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "United Kingdom",
      example: "7400123456",
      displayName: "United Kingdom (GB) [+44]",
      displayNameNoCountryCode: "United Kingdom (GB)",
      e164Key: "44-GB-0");

  File? image;
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final qualifiedController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final conformController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    phoneController.dispose();

    emailController.dispose();
    passwordController.dispose();
  }

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
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: kblackColor,
                                  size: 25,
                                )),
                            const CustomText(
                              text: "Account Details",
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              textcolor: kblackColor,
                            ),
                            Icon(
                              Icons.arrow_back_ios,
                              color: kTransparent,
                              size: 25,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          margin: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              // name field

                              textFeld(
                                hintText: "First Name",
                                icon: Icons.person,
                                inputType: TextInputType.name,
                                maxLines: 1,
                                controller: firstnameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter a First  Name";
                                  }

                                  return null;
                                },
                              ),

                              textFeld(
                                hintText: "Last Name",
                                icon: Icons.person,
                                inputType: TextInputType.emailAddress,
                                maxLines: 1,
                                controller: lastnameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter a Last Name";
                                  }
                                  return null;
                                },
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
                                        return "Password must be at least 7 characters, along special ,numeric , one Uppercase ";
                                      }
                                      return null;
                                    },
                                     textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          12, 12, 10, 15),
                                      prefixIcon: const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(12, 12, 10, 15),
                                        child: Icon(
                                          Icons.lock,
                                          color: kblackColor,
                                          size: 22,
                                        ),
                                      ),
                                      
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
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: kgreyColor)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: kgreyColor)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: kgreyColor)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: kgreyColor)),
                                    )),
                              ),

                              SizedBox(
                                height: 70,
                                child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    obscureText: ispassword,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please Re-enter a Password";
                                      } else if (!_isValidPassword(value)) {
                                        return "Password must be at least 7 characters, with at least one uppercase letter, one numeric digit, and one special character";
                                      } else if (value !=
                                          passwordController.text) {
                                        return "Passwords do not match";
                                      }
                                      return null;
                                    },
                                     textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          12, 12, 10, 15),
                                      prefixIcon: const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(12, 12, 10, 15),
                                        child: Icon(
                                          Icons.lock,
                                          color: kblackColor,
                                          size: 22,
                                        ),
                                      ),
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              ispassword = !ispassword;
                                            });
                                          },
                                          icon: ispassword
                                              ? (const Icon(
                                                  Icons.visibility_off,
                                                  color: kblackColor,
                                                ))
                                              : const Icon(
                                                  Icons.visibility,
                                                  color: kblackColor,
                                                )),
                                      hintText: "Confirm Password",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: kgreyColor)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: kgreyColor)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: kgreyColor)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: kgreyColor)),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 1.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: CustomButton(
                              text: "Create Account",
                              onPressed: () async {
                                _validation();
                              },
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: kgreyColor,
                              textColor: kwhiteColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
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
           textInputAction: TextInputAction.next,
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

  sendPhoneNumber() async {
    final CollectionReference collection =
        FirebaseFirestore.instance.collection('users');

    var querySnapshot = await collection
        .where("email", isEqualTo: "${emailController.text.toString()}")
        .get();

    print("Query Snapshot length: ${querySnapshot.docs.length}");

    for (var doc in querySnapshot.docs) {
      print("Found User: ${doc.id}");
    }

    if (querySnapshot.docs.isNotEmpty) {
      print("USER EXISTS");

      showSnackBar(
        context,
        "Account already exists. Please LOGIN",
      );
    } else {
      storeData();
    }
  }

//  store user data to database
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      roleCode: widget.roleCode,
      firstName: firstnameController.text.toString(),
      lastName: lastnameController.text.toString(),
      email: emailController.text.toLowerCase().toString(),
      password: passwordController.text.toString(),
      profilePic: dummyProfileImageUrl,
      createdAt: "",
      phoneNumber: "1234567890",
      customerId: "SL-${emailController.text.toLowerCase().toString()}",
    );

    ap.saveUserDataToFirebase(
      context: context,
      userModel: userModel,
      roleCode: widget.roleCode,
      qualified: SharedPrefServices.getqualified().toString(),
      onSuccess: () {
        ap.setSignIn().then((value) {
          SharedPrefServices.setfirstname(firstnameController.text.toString());
          SharedPrefServices.setlastname(lastnameController.text.toString());
          SharedPrefServices.setemail(
              emailController.text.toLowerCase().toString());
          SharedPrefServices.setphonenumber("1234567890");
          SharedPrefServices.setcustomerId(
              "SL-${emailController.text.toLowerCase().toString()}");
          SharedPrefServices.setroleCode(widget.roleCode);
          SharedPrefServices.setprofileimage(dummyProfileImageUrl);
          // SharedPrefServices.setqualified(widget.qualified);

          // SharedPrefServices.setcustomerId(widget.customerId);
          SharedPrefServices.setislogged(true);
          SharedPrefServices.setrememberme("true");
          SharedPrefServices.setroleCode("CUST");

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const Dashboard();
              },
            ),
          );
        });
      },
    );
  }
}
