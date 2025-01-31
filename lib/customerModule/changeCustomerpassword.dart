import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shuttleloungenew/const/color.dart';
import 'package:shuttleloungenew/customerModule/customerLogin/loginscreen.dart';
import 'package:shuttleloungenew/providers/auth_provider.dart';
import 'package:shuttleloungenew/sharedPreferences/sharedprefservices.dart';
import 'package:shuttleloungenew/utils/utils.dart';
import 'package:shuttleloungenew/widgets/custom_button.dart';
import 'package:shuttleloungenew/widgets/customtext.dart';
import 'package:shuttleloungenew/widgets/progressbar.dart';


class ChangecustomerPassword extends StatefulWidget {
  const ChangecustomerPassword({super.key});

  @override
  State<ChangecustomerPassword> createState() => _ChangecustomerPasswordState();
}

class _ChangecustomerPasswordState extends State<ChangecustomerPassword> {
  bool _isValidPassword(String password) {
    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{7,}$');
    return regex.hasMatch(password);
  }

  bool _isLoading = false;

  bool currentPassword = true;
  bool newPassword = true;
  bool confirmPassword = true;

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void updatePassword() async {
    setState(() {
      _isLoading = true;
    });

    final CollectionReference collection =
        FirebaseFirestore.instance.collection('users');
    String docId = SharedPrefServices.getdocumentId().toString();

    try {
      await collection.doc(docId).update({
        'password': newPasswordController.text,
      }).then(
        (value) {
          showSnackBar(context, "Password Updated Successfully");
        },
      ).catchError((e) {
        print(e);
      });
    } catch (error) {
      print("Data not updated: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: kwhiteColor,
          title: const CustomText(
              text: "Change Password",
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
        body: Stack(children: [
          Container(
            margin: const EdgeInsets.only(right: 15, left: 15),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const CustomText(
                      text: "Current Password",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textcolor: kblackColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: 70,
                        child: TextFormField(
                            // obscureText: currentPassword,
                            controller: currentPasswordController,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(12, 12, 10, 15),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(color: kgreyColor),
                              ),
                              prefixIcon: const Padding(
                                padding: EdgeInsets.fromLTRB(12, 12, 10, 15),
                                child: Icon(
                                  Icons.lock,
                                  color: kblackColor,
                                  size: 20,
                                ),
                              ),
                              suffixIcon:
                                  currentPasswordController.text.isNotEmpty
                                      ? (currentPasswordController.text ==
                                              SharedPrefServices.getpassword()
                                          ? const Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                            )
                                          : const Icon(
                                              Icons.cancel,
                                              color: Colors.red,
                                            ))
                                      : const Icon(
                                          Icons.remove_red_eye,
                                          color: kblackColor,
                                        ),
                              hintText: "Current Password",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: kgreyColor,
                                  width: 1.0,
                                ),
                              ),
                            ))),
                    const SizedBox(
                      height: 15,
                    ),
                    const CustomText(
                      text: "New Password",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textcolor: kblackColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 70,
                      child: TextFormField(
                          controller: newPasswordController,
                          keyboardType: TextInputType.text,
                          obscureText: newPassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter New  Password";
                            } else if (!_isValidPassword(value)) {
                              return "Password must be at least 7 characters, along special ,numeric , one Uppercase ";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(12, 12, 10, 15),
                            prefixIcon: const Padding(
                              padding: EdgeInsets.fromLTRB(12, 12, 10, 15),
                              child: Icon(
                                Icons.lock,
                                color: kblackColor,
                                size: 22,
                              ),
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    newPassword = !newPassword;
                                  });
                                },
                                icon: newPassword
                                    ? (const Icon(
                                        Icons.visibility_off,
                                        color: kblackColor,
                                      ))
                                    : const Icon(
                                        Icons.visibility,
                                        color: kblackColor,
                                      )),
                            hintText: "New Password",
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
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const CustomText(
                      text: "Confirm Password",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textcolor: kblackColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: 70,
                        child: TextFormField(
                            obscureText: confirmPassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Confirm New  Password";
                              } else if (!_isValidPassword(value)) {
                                return "Password must be at least 7 characters, with at least one uppercase letter, one numeric digit, and one special character";
                              } else if (value != newPasswordController.text) {
                                return "Passwords do not match";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(12, 12, 10, 15),
                              prefixIcon: const Padding(
                                padding: EdgeInsets.fromLTRB(12, 12, 10, 15),
                                child: Icon(
                                  Icons.lock,
                                  color: kblackColor,
                                  size: 20,
                                ),
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      confirmPassword = !confirmPassword;
                                    });
                                  },
                                  icon: confirmPassword
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
                            ))),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      text: "Change Password",
                      textColor: kwhiteColor,
                      onPressed: () async {
                        String oldpassword =
                            SharedPrefServices.getpassword().toString();

                        if (oldpassword == currentPasswordController.text) {
                          if (_formKey.currentState!.validate()) {
                            updatePassword();
                            ap.userUpdatePassword().then((value) {
                              Future.delayed(const Duration(seconds: 8), () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Loginscreen(),
                                  ),
                                );
                              });
                            });
                          }
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Current password is incorrect."),
                          ));
                        }
                      },
                      color: kgreyColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
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
        ]));
  }
}
