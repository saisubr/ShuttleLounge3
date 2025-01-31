import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shuttleloungenew/const/color.dart';
import 'package:shuttleloungenew/sharedPreferences/sharedprefservices.dart';
import 'package:shuttleloungenew/utils/utils.dart';
import 'package:shuttleloungenew/widgets/custom_button.dart';
import 'package:shuttleloungenew/widgets/customtext.dart';
import 'package:shuttleloungenew/widgets/progressbar.dart';


class ExpertEditProfile extends StatefulWidget {
  const ExpertEditProfile({super.key});

  @override
  State<ExpertEditProfile> createState() => _ExpertEditProfileState();
}

class _ExpertEditProfileState extends State<ExpertEditProfile> {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  bool _isLoading = false;

  File? image;
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController qualifiedController = TextEditingController();

  @override
  void initState() {
    super.initState();
    firstnameController.text = SharedPrefServices.getfirstname().toString();
    lastnameController.text = SharedPrefServices.getlastname().toString();
    qualifiedController.text = SharedPrefServices.getqualified().toString();
  }

  void updateProfile() async {
    setState(() {
      _isLoading = true;
    });

    final CollectionReference collection =
        FirebaseFirestore.instance.collection('experts');
    String docId = SharedPrefServices.getdocumentId().toString();

    try {
      String downloadURL = SharedPrefServices.getprofileimage().toString();

      if (image != null) {
        downloadURL = await uploadImage();
      }

      await collection.doc(docId).update({
        "firstName": firstnameController.text,
        "lastName": lastnameController.text,
        "profilePic": downloadURL,
        "qualified": qualifiedController.text,
      }).then(
        (value) {
          showSnackBar(context, "Data Updated Successfully");
        },
      ).catchError((e) {
        print(e);
      });
    } catch (error) {
      print("Data not updated: $error");
    }
  }

  void selectImage() async {
    image = await pickImage(context);
    setState(() {
      image = File(image!.path);
    });
  }

  Future<String> uploadImage() async {
    if (image == null) {
      print('Image is null');
      return '';
    }
    Reference ref = _firebaseStorage
        .ref()
        .child('profilePic')
        .child(SharedPrefServices.getprofileimage().toString());
    UploadTask uploadTask = ref.putFile(image!);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhiteColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: kwhiteColor,
        title: const CustomText(
            text: "Edit Profile",
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Stack(clipBehavior: Clip.none, children: [
                    image == null
                        ? CircleAvatar(
                            radius: 55,
                            backgroundImage: NetworkImage(
                                SharedPrefServices.getprofileimage()
                                    .toString()),
                          )
                        : CircleAvatar(
                            radius: 55,
                            backgroundImage: FileImage(image!),
                          ),
                    Positioned(
                        top: 65,
                        left: 85,
                        child: GestureDetector(
                          onTap: () => selectImage(),
                          child: const CircleAvatar(
                              backgroundColor: kgreyColor,
                              radius: 18,
                              child: Icon(
                                Icons.edit,
                                color: kwhiteColor,
                                size: 18,
                              )),
                        )),
                  ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                const CustomText(
                  text: "First Name",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  textcolor: kblackColor,
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                    height: 40,
                    child: TextFormField(
                        controller: firstnameController,
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
                              Icons.person,
                              color: kblackColor,
                              size: 20,
                            ),
                          ),
                          suffixIcon: const Icon(Icons.edit,
                              size: 18, color: kblackColor),
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
                  text: "Last Name",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  textcolor: kblackColor,
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                    height: 40,
                    child: TextFormField(
                        controller: lastnameController,
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
                              Icons.person,
                              color: kblackColor,
                              size: 20,
                            ),
                          ),
                          suffixIcon: const Icon(Icons.edit,
                              size: 18, color: kblackColor),
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
                  text: "Qualification",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  textcolor: kblackColor,
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                    height: 40,
                    child: TextFormField(
                        controller: qualifiedController,
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
                              Icons.description,
                              color: kblackColor,
                              size: 20,
                            ),
                          ),
                          suffixIcon: const Icon(Icons.edit,
                              size: 18, color: kblackColor),
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
                  text: "Email",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  textcolor: kblackColor,
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: kgreyColor),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, top: 5),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.email,
                          color: kblackColor,
                          size: 22,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomText(
                            text: SharedPrefServices.getemail().toString(),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            textcolor: kblackColor)
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // const CustomText(
                //   text: "Mobile Number",
                //   fontSize: 14,
                //   fontWeight: FontWeight.w400,
                //   textcolor: kblackColor,
                // ),
                // const SizedBox(
                //   height: 5,
                // ),
                // Container(
                //   height: 40,
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //       border: Border.all(color: kgreyColor),
                //       borderRadius: BorderRadius.circular(10)),
                //   child: Padding(
                //     padding: const EdgeInsets.only(left: 15, top: 5),
                //     child: Row(
                //       children: [
                //         const Icon(
                //           Icons.phone,
                //           color: kgreyColor,
                //           size: 22,
                //         ),
                //         const SizedBox(
                //           width: 10,
                //         ),
                //         CustomText(
                //             text:
                //                 SharedPrefServices.getphonenumber().toString(),
                //             fontSize: 14,
                //             fontWeight: FontWeight.w400,
                //             textcolor: kblackColor)
                //       ],
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 25,
                ),
                CustomButton(
                    text: "UPDATE",
                    textColor: kwhiteColor,
                    onPressed: () {
                      updateProfile();
                    },
                    color: kgreyColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)
              ],
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
}
