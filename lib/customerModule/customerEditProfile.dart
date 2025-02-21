import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shuttleloungenew/const/color.dart';
import 'package:shuttleloungenew/customerModule/bottomNavigationBarScreens/dashboard.dart';
import 'package:shuttleloungenew/sharedPreferences/sharedprefservices.dart';
import 'package:shuttleloungenew/utils/utils.dart';
import 'package:shuttleloungenew/widgets/custom_button.dart';
import 'package:shuttleloungenew/widgets/customtext.dart';
import 'package:shuttleloungenew/widgets/progressbar.dart';


class CustomerEditProfile extends StatefulWidget {
  const CustomerEditProfile({super.key});

  @override
  State<CustomerEditProfile> createState() => _CustomerEditProfileState();
}

class _CustomerEditProfileState extends State<CustomerEditProfile> {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  bool _isLoading = false;

  File? image;
  TextEditingController firstnameController =
      TextEditingController(text: SharedPrefServices.getfirstname().toString());
  TextEditingController lastnameController =
      TextEditingController(text: SharedPrefServices.getlastname().toString());

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    super.dispose();
  }
void updateProfile() async {
  setState(() {
    _isLoading = true;
  });

  final CollectionReference collection =
      FirebaseFirestore.instance.collection('users');
  String docId = SharedPrefServices.getdocumentId().toString();

  try {
    String existingProfilePic = SharedPrefServices.getprofileimage().toString();
    String downloadURL = existingProfilePic;

    if (image != null) {
      if (existingProfilePic.isNotEmpty) {
        try {
          Reference storageReference =
              FirebaseStorage.instance.refFromURL(existingProfilePic);
          await storageReference.delete();
        } catch (e) {
          print("Error deleting existing profile image: $e");
        }
      }
      downloadURL = await uploadImage();
    }

    String updatedFirstName = firstnameController.text;
    String updatedLastName = lastnameController.text;

    await collection.doc(docId).update({
      "firstName": updatedFirstName,
      "lastName": updatedLastName,
      "profilePic": downloadURL,
    }).then((value) async {
    
      await SharedPrefServices.setfirstname(updatedFirstName);
      await SharedPrefServices.setlastname(updatedLastName);
      await SharedPrefServices.setprofileimage(downloadURL);

      showSnackBar(context, "Data Updated Successfully");

      
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
        (route) => false,
      );
    }).catchError((e) {
      print(e);
    });
  } catch (error) {
    print("Data not updated: $error");
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}



Future<String> uploadImage() async {
  if (image == null) {
    print('Image is null');
    return '';
  }
 String userId = SharedPrefServices.getdocumentId().toString();
 String name = SharedPrefServices.getfirstname().toString();
 
  String folderName = 'edit_profile_images';
  String fileName =  '$name-/$userId.jpg';
    

  Reference ref = FirebaseStorage.instance.ref().child(folderName).child(fileName);
  UploadTask uploadTask = ref.putFile(image!);
  TaskSnapshot snapshot = await uploadTask;
  return await snapshot.ref.getDownloadURL();
}

  


  void selectImage() async {
    image = await pickImage(context);
    setState(() {
      image = File(image!.path);
    });
  }

  

  @override
  Widget build(BuildContext context) {
    print('Document ID');
    print(SharedPrefServices.getdocumentId().toString());
    
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




  // void updateProfile() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   final CollectionReference collection =
  //       FirebaseFirestore.instance.collection('users');
  //   String docId = SharedPrefServices.getdocumentId().toString();

  //   try {
  //     String downloadURL = SharedPrefServices.getprofileimage().toString();

  //     if (image != null) {
  //       downloadURL = await uploadImage();
  //     }

  //     await collection.doc(docId).update({
  //       "firstName": firstnameController.text,
  //       "lastName": lastnameController.text,
  //       "profilePic": downloadURL,
  //     }).then(
  //       (value) {
  //         showSnackBar(context, "Data Updated Successfully");
  //       },
  //     ).catchError((e) {
  //       print(e);
  //     });
  //   } catch (error) {
  //     print("Data not updated: $error");
  //   }
  // }
  // Future<String> uploadImage() async {
  //   if (image == null) {
  //     print('Image is null');
  //     return '';
  //   }
  //   Reference ref = _firebaseStorage
  //       .ref()
  //       .child('profilePic')
  //       .child(SharedPrefServices.getprofileimage().toString());
  //   UploadTask uploadTask = ref.putFile(image!);
  //   TaskSnapshot snapshot = await uploadTask;
  //   String downloadURL = await snapshot.ref.getDownloadURL();
  //   return downloadURL;
  // }