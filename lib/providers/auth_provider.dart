import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shuttleloungenew/models/custom_model.dart';
import 'package:shuttleloungenew/models/expert_model.dart';
import 'package:shuttleloungenew/models/user_model.dart';
import 'package:shuttleloungenew/registration/otp_screen.dart';
import 'package:shuttleloungenew/sharedPreferences/sharedprefservices.dart';
import 'package:shuttleloungenew/utils/utils.dart';


class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  String get uid => _uid!;
  UserModel? _userModel;
  UserModel? get userModel => _userModel;
  CustomModel? _customModel;
  CustomModel? get customModel => _customModel;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  List<Map<String, dynamic>> _reviewRequests = [];

  List<Map<String, dynamic>> get reviewRequests => _reviewRequests;

  AuthProvider() {
    checkSignIn();
  }
  void checkSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin") ?? false;
    notifyListeners();
  }

  void signInwithPhone(
      BuildContext context,
      String phoneNumber,
      String email,
      String firstName,
      String lastName,
      String password,
      File image,
      String roleCode,
      String qualified) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Otp_screen(
                    verificationId: verificationId,
                    email: email,
                    firstName: firstName,
                    lastName: lastName,
                    password: password,
                    phoneNumber: phoneNumber,
                    roleCode: roleCode,
                    qualified: qualified,
                    image: image),
              ),
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);

      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;

      if (user != null) {
        // carry our logic
        _uid = user.uid;
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> checkExistingUser(String roleCode) async {
    if (roleCode == "CUST") {
      DocumentSnapshot snapshot =
          await _firebaseFirestore.collection("users").doc(_uid).get();
      if (snapshot.exists) {
        print("USER EXISTS");
        return true;
      } else {
        print("NEW USER");
        return false;
      }
    } else if (roleCode == "EXPERT") {
      DocumentSnapshot snapshot =
          await _firebaseFirestore.collection("experts").doc(_uid).get();
      if (snapshot.exists) {
        print("EXPERT EXISTS");
        return true;
      } else {
        print("NEW EXPERT");
        return false;
      }
    }
    return (false);
  }

  Future getDataFromFirestore() async {
    await _firebaseFirestore
        .collection("users")
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      SharedPrefServices.setfirstname(snapshot['firstName']);
      SharedPrefServices.setlastname(snapshot['lastName']);
      SharedPrefServices.setemail(snapshot['email']);
      SharedPrefServices.setphonenumber(snapshot['phoneNumber']);
      SharedPrefServices.setprofileimage(snapshot['profilePic']);
      SharedPrefServices.setpassword(snapshot['password']);
      SharedPrefServices.setdocumentId(snapshot.id);
      _uid = snapshot['customerId'];
    });
  }

  Future<List<Map<String, dynamic>>> recenttabVideodetails() async {
    try {
      QuerySnapshot userQuerySnapshot = await _firebaseFirestore
          .collection('users')
          .where("customerId",
              isEqualTo: SharedPrefServices.getcustomerId().toString())
          .limit(1)
          .get();

      if (userQuerySnapshot.docs.isEmpty) {
        print("User document not found");
        return [];
      }
      DocumentSnapshot userSnapshot = userQuerySnapshot.docs.first;
      String customerId = userSnapshot['customerId'] ?? '';
      String firstName = userSnapshot['firstName'] ?? '';
      String lastName = userSnapshot['lastName'] ?? '';
      String profilePic = userSnapshot['profilePic'] ?? '';

      DateTime now = DateTime.now();
      DateTime sevenDaysAgo = now.subtract(const Duration(days: 7));

      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection('requestedReviews')
          .where("cust_Id", isEqualTo: customerId)
          .where("timestamp", isGreaterThanOrEqualTo: sevenDaysAgo)
          .where("timestamp", isLessThanOrEqualTo: now)
          .orderBy('timestamp', descending: true)
          .get();

      List<Map<String, dynamic>> videoDetails = [];

      List<Map<String, dynamic>> intermediateDetails = [];

      for (var doc in querySnapshot.docs) {
        intermediateDetails.add({
          'yTUrl': doc['yTUrl'],
          'cust_Question': doc['cust_Question'],
          'cust_Id': doc['cust_Id'],
          'is_Answered': doc['is_Answered'],
          'docId': doc.id,
          'expert_queue_Id': doc['expert_queue_Id'] ?? "",
          'timeStamp': doc['timestamp'] ?? "",
          'expertAnswer': doc['expertAnswer'] ?? "",
          'firstName': firstName,
          'lastName': lastName,
          'profilePic': profilePic,
          'queries': doc['queries']
        });
      }
      for (var doc in intermediateDetails) {
        if (doc['expert_queue_Id'].toString().isNotEmpty) {
          QuerySnapshot expertQuerySnapshot = await _firebaseFirestore
              .collection('experts')
              .where("expertId", isEqualTo: doc['expert_queue_Id'])
              .limit(1)
              .get();
          if (expertQuerySnapshot.docs.isEmpty) {
            print("User document not found");
            return [];
          }
          DocumentSnapshot expertSnapshot = expertQuerySnapshot.docs.first;
          String expertFirstName = expertSnapshot['firstName'] ?? '';
          String expertLastName = expertSnapshot['lastName'] ?? '';
          String expertProfilePic = expertSnapshot['profilePic'] ?? '';

          int conversationCount = doc['queries']?.length ?? 0;

          videoDetails.add({
            'yTUrl': doc['yTUrl'],
            'cust_Question': doc['cust_Question'],
            'cust_Id': doc['cust_Id'],
            'is_Answered': doc['is_Answered'],
            'docId': doc['docId'],
            'expert_queue_Id': doc['expert_queue_Id'] ?? "",
            'timeStamp': doc['timeStamp'],
            'expertAnswer': doc['expertAnswer'] ?? "",
            "queries": doc['queries'] ?? [],
            'firstName': firstName,
            'lastName': lastName,
            'profilePic': profilePic,
            'expertFirstname': expertFirstName,
            'expertLastname': expertLastName,
            'expertProfilepic': expertProfilePic,
            'conversationCount': conversationCount,
          });
        } else {
          int conversationCount = doc['queries']?.length ?? 0;
          videoDetails.add({
            'yTUrl': doc['yTUrl'],
            'cust_Question': doc['cust_Question'],
            'cust_Id': doc['cust_Id'],
            'is_Answered': doc['is_Answered'],
            'docId': doc['docId'],
            'expert_queue_Id': doc['expert_queue_Id'] ?? "",
            'timeStamp': doc['timeStamp'],
            'expertAnswer': doc['expertAnswer'] ?? "",
            "queries": doc['queries'] ?? [],
            'firstName': firstName,
            'lastName': lastName,
            'profilePic': profilePic,
            'expertFirstname': '',
            'expertLastname': '',
            'expertProfilepic': '',
            'conversationCount': conversationCount,
          });
        }
      }

      return videoDetails;
    } catch (error) {
      print("Error fetching video details: $error");
      return [];
    }
  }

  // /////////////////////requested reviews

  Future<List<Map<String, dynamic>>> requestedReviews() async {
    try {
      QuerySnapshot userQuerySnapshot = await _firebaseFirestore
          .collection('users')
          .where("customerId",
              isEqualTo: SharedPrefServices.getcustomerId().toString())
              
          .limit(1)
          .get();

      if (userQuerySnapshot.docs.isEmpty) {
        print("User document not found");
        return [];
      }
      DocumentSnapshot userSnapshot = userQuerySnapshot.docs.first;
      String customerId = userSnapshot['customerId'] ?? '';
      String firstName = userSnapshot['firstName'] ?? '';
      String lastName = userSnapshot['lastName'] ?? '';
      String profilePic = userSnapshot['profilePic'] ?? '';

      // DateTime now = DateTime.now();
      // DateTime sevenDaysAgo = now.subtract(const Duration(days: 7));

      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection('requestedReviews')
          .where("cust_Id", isEqualTo: customerId)
          .orderBy('timestamp', descending: true)
          
          // .where("is_Answered", isEqualTo: "HOLD")s
          .where("is_Answered", whereIn: ['HOLD', 'FALSE']).get();

      List<Map<String, dynamic>> videoDetails = [];

      List<Map<String, dynamic>> intermediateDetails = [];

      for (var doc in querySnapshot.docs) {
        intermediateDetails.add({
          'yTUrl': doc['yTUrl'],
          'cust_Question': doc['cust_Question'],
          'cust_Id': doc['cust_Id'],
          'is_Answered': doc['is_Answered'],
          'docId': doc.id,
          'expert_queue_Id': doc['expert_queue_Id'] ?? "",
          'timeStamp': doc['timestamp'] ?? "",
          'expertAnswer': doc['expertAnswer'] ?? "",
          'firstName': firstName,
          'lastName': lastName,
          'profilePic': profilePic,
          'queries': doc['queries']
        });
      }
      for (var doc in intermediateDetails) {
        if (doc['expert_queue_Id'].toString().isNotEmpty) {
          QuerySnapshot expertQuerySnapshot = await _firebaseFirestore
              .collection('experts')
              .where("expertId", isEqualTo: doc['expert_queue_Id'])
              .limit(1)
              .get();
          if (expertQuerySnapshot.docs.isEmpty) {
            print("User document not found");
            return [];
          }
          DocumentSnapshot expertSnapshot = expertQuerySnapshot.docs.first;
          String expertFirstName = expertSnapshot['firstName'] ?? '';
          String expertLastName = expertSnapshot['lastName'] ?? '';
          String expertProfilePic = expertSnapshot['profilePic'] ?? '';

          int conversationCount = doc['queries']?.length ?? 0;

          videoDetails.add({
            'yTUrl': doc['yTUrl'],
            'cust_Question': doc['cust_Question'],
            'cust_Id': doc['cust_Id'],
            'is_Answered': doc['is_Answered'],
            'docId': doc['docId'],
            'expert_queue_Id': doc['expert_queue_Id'] ?? "",
            'timeStamp': doc['timeStamp'],
            'expertAnswer': doc['expertAnswer'] ?? "",
            "queries": doc['queries'] ?? [],
            'firstName': firstName,
            'lastName': lastName,
            'profilePic': profilePic,
            'expertFirstname': expertFirstName,
            'expertLastname': expertLastName,
            'expertProfilepic': expertProfilePic,
            'conversationCount': conversationCount,
          });
        } else {
          int conversationCount = doc['queries']?.length ?? 0;
          videoDetails.add({
            'yTUrl': doc['yTUrl'],
            'cust_Question': doc['cust_Question'],
            'cust_Id': doc['cust_Id'],
            'is_Answered': doc['is_Answered'],
            'docId': doc['docId'],
            'expert_queue_Id': doc['expert_queue_Id'] ?? "",
            'timeStamp': doc['timeStamp'],
            'expertAnswer': doc['expertAnswer'] ?? "",
            "queries": doc['queries'] ?? [],
            'firstName': firstName,
            'lastName': lastName,
            'profilePic': profilePic,
            'expertFirstname': '',
            'expertLastname': '',
            'expertProfilepic': '',
            'conversationCount': conversationCount,
          });
        }
      }

      return videoDetails;
    } catch (error) {
      print("Error fetching video details: $error");
      return [];
    }
  }

  // ///// reviewed list

  Future<List<Map<String, dynamic>>> reviewedReviews() async {
    try {
      QuerySnapshot userQuerySnapshot = await _firebaseFirestore
          .collection('users')
          .where("customerId",
              isEqualTo: SharedPrefServices.getcustomerId().toString())
              
          .limit(1)
          .get();

      if (userQuerySnapshot.docs.isEmpty) {
        print("User document not found");
        return [];
      }
      DocumentSnapshot userSnapshot = userQuerySnapshot.docs.first;
      String customerId = userSnapshot['customerId'] ?? '';
      String firstName = userSnapshot['firstName'] ?? '';
      String lastName = userSnapshot['lastName'] ?? '';
      String profilePic = userSnapshot['profilePic'] ?? '';

      // DateTime now = DateTime.now();
      // DateTime sevenDaysAgo = now.subtract(const Duration(days: 7));

      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection('requestedReviews')
          .where("cust_Id", isEqualTo: customerId)
          .where("is_Answered", isEqualTo: "TRUE")
           .orderBy('timestamp', descending: true)
          // .where("is_Answered", whereIn: ['HOLD', 'FALSE'])
          .get();

      List<Map<String, dynamic>> videoDetails = [];

      List<Map<String, dynamic>> intermediateDetails = [];

      for (var doc in querySnapshot.docs) {
        intermediateDetails.add({
          'yTUrl': doc['yTUrl'],
          'cust_Question': doc['cust_Question'],
          'cust_Id': doc['cust_Id'],
          'is_Answered': doc['is_Answered'],
          'docId': doc.id,
          'expert_queue_Id': doc['expert_queue_Id'] ?? "",
          'timeStamp': doc['timestamp'] ?? "",
          'expertAnswer': doc['expertAnswer'] ?? "",
          'firstName': firstName,
          'lastName': lastName,
          'profilePic': profilePic,
          'queries': doc['queries']
        });
      }
      for (var doc in intermediateDetails) {
        if (doc['expert_queue_Id'].toString().isNotEmpty) {
          QuerySnapshot expertQuerySnapshot = await _firebaseFirestore
              .collection('experts')
              .where("expertId", isEqualTo: doc['expert_queue_Id'])
              .limit(1)
              .get();
          if (expertQuerySnapshot.docs.isEmpty) {
            print("User document not found");
            return [];
          }
          DocumentSnapshot expertSnapshot = expertQuerySnapshot.docs.first;
          String expertFirstName = expertSnapshot['firstName'] ?? '';
          String expertLastName = expertSnapshot['lastName'] ?? '';
          String expertProfilePic = expertSnapshot['profilePic'] ?? '';

          int conversationCount = doc['queries']?.length ?? 0;

          videoDetails.add({
            'yTUrl': doc['yTUrl'],
            'cust_Question': doc['cust_Question'],
            'cust_Id': doc['cust_Id'],
            'is_Answered': doc['is_Answered'],
            'docId': doc['docId'],
            'expert_queue_Id': doc['expert_queue_Id'] ?? "",
            'timeStamp': doc['timeStamp'],
            'expertAnswer': doc['expertAnswer'] ?? "",
            "queries": doc['queries'] ?? [],
            'firstName': firstName,
            'lastName': lastName,
            'profilePic': profilePic,
            'expertFirstname': expertFirstName,
            'expertLastname': expertLastName,
            'expertProfilepic': expertProfilePic,
            'conversationCount': conversationCount,
          });
        } else {
          int conversationCount = doc['queries']?.length ?? 0;
          videoDetails.add({
            'yTUrl': doc['yTUrl'],
            'cust_Question': doc['cust_Question'],
            'cust_Id': doc['cust_Id'],
            'is_Answered': doc['is_Answered'],
            'docId': doc['docId'],
            'expert_queue_Id': doc['expert_queue_Id'] ?? "",
            'timeStamp': doc['timeStamp'],
            'expertAnswer': doc['expertAnswer'] ?? "",
            "queries": doc['queries'] ?? [],
            'firstName': firstName,
            'lastName': lastName,
            'profilePic': profilePic,
            'expertFirstname': '',
            'expertLastname': '',
            'expertProfilepic': '',
            'conversationCount': conversationCount,
          });
        }
      }

      return videoDetails;
    } catch (error) {
      print("Error fetching video details: $error");
      return [];
    }
  }

  ////////////////////////

  Future<List<Map<String, dynamic>>> lastweektabVideodetails() async {
    try {
      QuerySnapshot userQuerySnapshot = await _firebaseFirestore
          .collection('users')
          .where("customerId",
              isEqualTo: SharedPrefServices.getcustomerId().toString())
          .limit(1)
          .get();

      if (userQuerySnapshot.docs.isEmpty) {
        print("User document not found");
        return [];
      }
      DocumentSnapshot userSnapshot = userQuerySnapshot.docs.first;
      String customerId = userSnapshot['customerId'] ?? '';
      String firstName = userSnapshot['firstName'] ?? '';
      String lastName = userSnapshot['lastName'] ?? '';
      String profilePic = userSnapshot['profilePic'] ?? '';

      DateTime now = DateTime.now();
      DateTime lastWeek = now.subtract(const Duration(days: 7));
      DateTime twoWeeksAgo = now.subtract(const Duration(days: 14));

      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection('requestedReviews')
          .where("cust_Id", isEqualTo: customerId)
          .where("timestamp", isGreaterThan: twoWeeksAgo)
          .where("timestamp", isLessThan: lastWeek)
          .orderBy('timestamp', descending: true)
          .get();

      List<Map<String, dynamic>> videoDetails = [];

      List<Map<String, dynamic>> intermediateDetails = [];

      for (var doc in querySnapshot.docs) {
        intermediateDetails.add({
          'yTUrl': doc['yTUrl'],
          'cust_Question': doc['cust_Question'],
          'cust_Id': doc['cust_Id'],
          'is_Answered': doc['is_Answered'],
          'docId': doc.id,
          'expert_queue_Id': doc['expert_queue_Id'] ?? "",
          'timeStamp': doc['timestamp'] ?? "",
          'expertAnswer': doc['expertAnswer'] ?? "",
          'firstName': firstName,
          'lastName': lastName,
          'profilePic': profilePic,
          'queries': doc['queries']
        });
      }
      for (var doc in intermediateDetails) {
        if (doc['expert_queue_Id'].toString().isNotEmpty) {
          QuerySnapshot expertQuerySnapshot = await _firebaseFirestore
              .collection('experts')
              .where("expertId", isEqualTo: doc['expert_queue_Id'])
              .limit(1)
              .get();
          if (expertQuerySnapshot.docs.isEmpty) {
            print("User document not found");
            return [];
          }
          DocumentSnapshot expertSnapshot = expertQuerySnapshot.docs.first;
          String expertFirstName = expertSnapshot['firstName'] ?? '';
          String expertLastName = expertSnapshot['lastName'] ?? '';
          String expertProfilePic = expertSnapshot['profilePic'] ?? '';

          int conversationCount = doc['queries']?.length ?? 0;

          videoDetails.add({
            'yTUrl': doc['yTUrl'],
            'cust_Question': doc['cust_Question'],
            'cust_Id': doc['cust_Id'],
            'is_Answered': doc['is_Answered'],
            'docId': doc['docId'],
            'expert_queue_Id': doc['expert_queue_Id'] ?? "",
            'timeStamp': doc['timeStamp'],
            'expertAnswer': doc['expertAnswer'] ?? "",
            "queries": doc['queries'] ?? [],
            'firstName': firstName,
            'lastName': lastName,
            'profilePic': profilePic,
            'expertFirstname': expertFirstName,
            'expertLastname': expertLastName,
            'expertProfilepic': expertProfilePic,
            'conversationCount': conversationCount,
          });
        } else {
          int conversationCount = doc['queries']?.length ?? 0;
          videoDetails.add({
            'yTUrl': doc['yTUrl'],
            'cust_Question': doc['cust_Question'],
            'cust_Id': doc['cust_Id'],
            'is_Answered': doc['is_Answered'],
            'docId': doc['docId'],
            'expert_queue_Id': doc['expert_queue_Id'] ?? "",
            'timeStamp': doc['timeStamp'],
            'expertAnswer': doc['expertAnswer'] ?? "",
            "queries": doc['queries'] ?? [],
            'firstName': firstName,
            'lastName': lastName,
            'profilePic': profilePic,
            'expertFirstname': '',
            'expertLastname': '',
            'expertProfilepic': '',
            'conversationCount': conversationCount,
          });
        }
      }

      return videoDetails;
    } catch (error) {
      print("Error fetching video details: $error");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> oldertabVideodetails() async {
    try {
      QuerySnapshot userQuerySnapshot = await _firebaseFirestore
          .collection('users')
          .where("customerId",
              isEqualTo: SharedPrefServices.getcustomerId().toString())
          .limit(1)
          .get();

      if (userQuerySnapshot.docs.isEmpty) {
        print("User document not found");
        return [];
      }
      DocumentSnapshot userSnapshot = userQuerySnapshot.docs.first;
      String customerId = userSnapshot['customerId'] ?? '';
      String firstName = userSnapshot['firstName'] ?? '';
      String lastName = userSnapshot['lastName'] ?? '';
      String profilePic = userSnapshot['profilePic'] ?? '';

      DateTime now = DateTime.now();
      DateTime twoWeeksAgo = now.subtract(const Duration(days: 14));

      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection('requestedReviews')
          .where("cust_Id", isEqualTo: customerId)
          .where("timestamp", isLessThan: twoWeeksAgo)
          .orderBy('timestamp', descending: true)
          .get();

      List<Map<String, dynamic>> videoDetails = [];

      List<Map<String, dynamic>> intermediateDetails = [];

      for (var doc in querySnapshot.docs) {
        intermediateDetails.add({
          'yTUrl': doc['yTUrl'],
          'cust_Question': doc['cust_Question'],
          'cust_Id': doc['cust_Id'],
          'is_Answered': doc['is_Answered'],
          'docId': doc.id,
          'expert_queue_Id': doc['expert_queue_Id'] ?? "",
          'timeStamp': doc['timestamp'] ?? "",
          'expertAnswer': doc['expertAnswer'] ?? "",
          'firstName': firstName,
          'lastName': lastName,
          'profilePic': profilePic,
          'queries': doc['queries']
        });
      }
      for (var doc in intermediateDetails) {
        if (doc['expert_queue_Id'].toString().isNotEmpty) {
          QuerySnapshot expertQuerySnapshot = await _firebaseFirestore
              .collection('experts')
              .where("expertId", isEqualTo: doc['expert_queue_Id'])
              .limit(1)
              .get();
          if (expertQuerySnapshot.docs.isEmpty) {
            print("User document not found");
            return [];
          }
          DocumentSnapshot expertSnapshot = expertQuerySnapshot.docs.first;
          String expertFirstName = expertSnapshot['firstName'] ?? '';
          String expertLastName = expertSnapshot['lastName'] ?? '';
          String expertProfilePic = expertSnapshot['profilePic'] ?? '';

          int conversationCount = doc['queries']?.length ?? 0;

          videoDetails.add({
            'yTUrl': doc['yTUrl'],
            'cust_Question': doc['cust_Question'],
            'cust_Id': doc['cust_Id'],
            'is_Answered': doc['is_Answered'],
            'docId': doc['docId'],
            'expert_queue_Id': doc['expert_queue_Id'] ?? "",
            'timeStamp': doc['timeStamp'],
            'expertAnswer': doc['expertAnswer'] ?? "",
            "queries": doc['queries'] ?? [],
            'firstName': firstName,
            'lastName': lastName,
            'profilePic': profilePic,
            'expertFirstname': expertFirstName,
            'expertLastname': expertLastName,
            'expertProfilepic': expertProfilePic,
            'conversationCount': conversationCount,
          });
        } else {
          int conversationCount = doc['queries']?.length ?? 0;
          videoDetails.add({
            'yTUrl': doc['yTUrl'],
            'cust_Question': doc['cust_Question'],
            'cust_Id': doc['cust_Id'],
            'is_Answered': doc['is_Answered'],
            'docId': doc['docId'],
            'expert_queue_Id': doc['expert_queue_Id'] ?? "",
            'timeStamp': doc['timeStamp'],
            'expertAnswer': doc['expertAnswer'] ?? "",
            "queries": doc['queries'] ?? [],
            'firstName': firstName,
            'lastName': lastName,
            'profilePic': profilePic,
            'expertFirstname': '',
            'expertLastname': '',
            'expertProfilepic': '',
            'conversationCount': conversationCount,
          });
        }
      }

      return videoDetails;
    } catch (error) {
      print("Error fetching video details: $error");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> expertGreyList() async {
    try {
      // Fetch video details from Firestore
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection('requestedReviews')
          .where('expert_queue_Id', isEqualTo: '')
          .where("is_Answered", isEqualTo: "FALSE")
          .orderBy('timestamp', descending: true)
          .get();

      List<Map<String, dynamic>> videoUpdatedDetails = [];

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        QuerySnapshot userQuerySnapshot = await _firebaseFirestore
            .collection('users')
            .where("customerId", isEqualTo: doc['cust_Id'])
            .limit(1)
            .get();

        if (userQuerySnapshot.docs.isNotEmpty) {
          DocumentSnapshot userSnapshot = userQuerySnapshot.docs.first;
          String firstName = userSnapshot['firstName'] ?? '';
          String lastName = userSnapshot['lastName'] ?? '';
          String profilePic = userSnapshot['profilePic'] ?? '';

          Map<String, dynamic> userDetails = {
            'yTUrl': doc['yTUrl'],
            'cust_Question': doc['cust_Question'],
            'cust_Id': doc['cust_Id'],
            'cust_Name': "$firstName $lastName",
            'cust_Profilepic': profilePic,
            'is_Answered': doc['is_Answered'],
            'docId': doc.id,
            'expertAnswer': doc['expertAnswer'],
          };
          videoUpdatedDetails.add(userDetails);
        } else {
          print("User document not found for custId: $doc['cust_Id']");
        }
      }

      print("Now printing videoUpdatedDetails");
      print(videoUpdatedDetails[0]);
      inspect(videoUpdatedDetails);
      print(videoUpdatedDetails[0]['cust_Name']);
      return videoUpdatedDetails;
    } catch (error) {
      print("Error fetching video details: $error");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> expertBlueList() async {
    try {
      // Fetch video details from Firestore
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection('requestedReviews')
          .where('expert_queue_Id', isEqualTo: SharedPrefServices.getexpertId())
          .where("is_Answered", isEqualTo: "HOLD")
          .orderBy('timestamp', descending: true)
          .get();

      List<Map<String, dynamic>> videoUpdatedDetails = [];

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        QuerySnapshot userQuerySnapshot = await _firebaseFirestore
            .collection('users')
            .where("customerId", isEqualTo: doc['cust_Id'])
            .limit(1)
            .get();

        if (userQuerySnapshot.docs.isNotEmpty) {
          DocumentSnapshot userSnapshot = userQuerySnapshot.docs.first;
          String firstName = userSnapshot['firstName'] ?? '';
          String lastName = userSnapshot['lastName'] ?? '';
          String profilePic = userSnapshot['profilePic'] ?? '';

          Map<String, dynamic> userDetails = {
            'yTUrl': doc['yTUrl'],
            'cust_Question': doc['cust_Question'],
            'cust_Id': doc['cust_Id'],
            'cust_Name': "$firstName $lastName",
            'cust_Profilepic': profilePic,
            'is_Answered': doc['is_Answered'],
            'docId': doc.id,
            'expertAnswer': doc['expertAnswer'],
          };
          videoUpdatedDetails.add(userDetails);
        } else {
          print("User document not found for custId: $doc['cust_Id']");
        }
      }

      print("Now printing videoUpdatedDetails");
      print(videoUpdatedDetails[0]);
      inspect(videoUpdatedDetails);
      print(videoUpdatedDetails[0]['cust_Name']);
      return videoUpdatedDetails;
    } catch (error) {
      print("Error fetching video details: $error");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> expertGreenList() async {
    try {
      // Fetch video details from Firestore
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection('requestedReviews')
          .where('expert_queue_Id', isEqualTo: SharedPrefServices.getexpertId())
          .where("is_Answered", isEqualTo: "TRUE")
          .orderBy('timestamp', descending: true)
          .get();

      List<Map<String, dynamic>> videoUpdatedDetails = [];

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        QuerySnapshot userQuerySnapshot = await _firebaseFirestore
            .collection('users')
            .where("customerId", isEqualTo: doc['cust_Id'])
            .limit(1)
            .get();

        if (userQuerySnapshot.docs.isNotEmpty) {
          DocumentSnapshot userSnapshot = userQuerySnapshot.docs.first;
          String firstName = userSnapshot['firstName'] ?? '';
          String lastName = userSnapshot['lastName'] ?? '';
          String profilePic = userSnapshot['profilePic'] ?? '';

          int conversationCount = doc['queries']?.length ?? 0;

          Map<String, dynamic> userDetails = {
            'yTUrl': doc['yTUrl'],
            'cust_Question': doc['cust_Question'],
            'cust_Id': doc['cust_Id'],
            'cust_Name': "$firstName $lastName",
            'cust_Profilepic': profilePic,
            'is_Answered': doc['is_Answered'],
            'docId': doc.id,
            'expertAnswer': doc['expertAnswer'],
            'queries': doc['queries'],
            'conversationCount': conversationCount
          };
          videoUpdatedDetails.add(userDetails);
        } else {
          print("User document not found for custId: $doc['cust_Id']");
        }
      }
      print("Now printing videoUpdatedDetails");
      print(videoUpdatedDetails[0]);
      inspect(videoUpdatedDetails);
      print(videoUpdatedDetails[0]['cust_Name']);
      return videoUpdatedDetails;
    } catch (error) {
      print("Error fetching video details: $error");
      return [];
    }
  }

// login method
  // Future login(String phoneNumber) async {
  //   await _firebaseFirestore
  //       .collection("users")
  //       .where("phoneNumber", isEqualTo: phoneNumber)
  //       .get()
  //       .then((DocumentSnapshot snapshot) {
  //         _userModel = UserModel(
  //           firstName: snapshot['firstName'],
  //           lastName: snapshot['lastName'],
  //           email: snapshot['email'],
  //           createdAt: snapshot['createdAt'],
  //           password: snapshot['password'],
  //           customerId: snapshot['customerId'],
  //           profilePic: snapshot['profilePic'],
  //           phoneNumber: snapshot['phoneNumber'],
  //         );
  //         _uid = userModel.customerId;
  //         print(_userModel);
  //         inspect(_userModel);
  //       });
  // }

  //

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    _isSignedIn = true;
    notifyListeners();
  }

  Future saveUserDataToSP() async {
    // SharedPreferences s = await SharedPreferences.getInstance();
    // await s.setString("user_model", jsonEncode(userModel!.toMap()));

    SharedPrefServices.setfirstname(userModel!.firstName);
    SharedPrefServices.setlastname(userModel!.lastName);
    SharedPrefServices.setemail(userModel!.email);
    SharedPrefServices.setphonenumber(userModel!.phoneNumber);
    SharedPrefServices.setprofileimage(userModel!.profilePic);
    SharedPrefServices.setcustomerId(userModel!.customerId);
    SharedPrefServices.setpassword(userModel!.password);
  }

  void saveUserDataToFirebase({
    required BuildContext context,
    required UserModel userModel,
    required String roleCode,
    // required File profilePic,
    required Function onSuccess,
    required String qualified,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      // uploading image to firebase storage.
      // await storeFileToStorage(
      //   "profilePic/$_uid",
      //   profilePic,
      // ).then((value) {
      //   userModel.profilePic = value;
      //   userModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
      //   // userModel.phoneNumber = "1234567890";
      //   // userModel.customerId = _firebaseAuth.currentUser!.phoneNumber!;
      //   SharedPrefServices.setprofileimage(value);
      // });
      if (roleCode == "CUST") {
        _userModel = userModel;
        await _firebaseFirestore
            .collection("users")
            .doc(_uid)
            .set(userModel.toMap())
            .then((value) {
          onSuccess();
          _isLoading = false;
          notifyListeners();
        });
      } else if (roleCode == "EXPERT") {
        ExpertModel expertModel = ExpertModel(
            firstName: userModel.firstName,
            email: userModel.email,
            lastName: userModel.lastName,
            profilePic: userModel.profilePic,
            createdAt: userModel.createdAt,
            phoneNumber: userModel.phoneNumber,
            expertId: "EXP${userModel.customerId}",
            password: userModel.password,
            qualified: SharedPrefServices.getqualified().toString(),
            roleCode: roleCode);

        await _firebaseFirestore
            .collection("experts")
            .doc(_uid)
            .set(expertModel.toMap())
            .then((value) {
          onSuccess();
          _isLoading = false;
          notifyListeners();
        });
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> storeFileToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future userSignOut() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await _firebaseAuth.signOut();
    _isSignedIn = false;
    notifyListeners();
    s.clear();
  }

  Future userUpdatePassword() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await _firebaseAuth.signOut();
    _isSignedIn = false;
    notifyListeners();
    SharedPrefServices.clearUserFromSharedPrefs();
    s.clear();
  }
}
