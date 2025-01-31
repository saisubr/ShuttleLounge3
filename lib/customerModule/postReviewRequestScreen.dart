import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shuttleloungenew/const/color.dart';
import 'package:shuttleloungenew/customerModule/bottomNavigationBarScreens/dashboard.dart';
import 'package:shuttleloungenew/customerModule/customerSidemenu.dart';
import 'package:shuttleloungenew/models/custom_model.dart';
import 'package:shuttleloungenew/sharedPreferences/sharedprefservices.dart';
import 'package:shuttleloungenew/widgets/custom_button.dart';
import 'package:shuttleloungenew/widgets/customtext.dart';
import 'package:shuttleloungenew/widgets/progressbar.dart';
import 'package:video_url_validator/video_url_validator.dart';

class PostReviewRequestScreen extends StatefulWidget {
  const PostReviewRequestScreen({super.key});

  @override
  State<PostReviewRequestScreen> createState() =>
      _PostReviewRequestScreenState();
}

class _PostReviewRequestScreenState extends State<PostReviewRequestScreen> {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  TextEditingController urlcontroller = TextEditingController();
  TextEditingController questioncontroller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool onSubmit = false;

  bool showProgressIndicator = false;

  final VideoURLValidator _validator = VideoURLValidator();

  @override
  void dispose() {
    super.dispose();
    urlcontroller.dispose();

    questioncontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: kwhiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kwhiteColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              scaffoldKey.currentState?.openDrawer();
            },
            child: CircleAvatar(
              backgroundColor: kgreyColor,
              backgroundImage: NetworkImage(
                SharedPrefServices.getprofileimage().toString(),
              ),
              radius: 10,
            ),
          ),
        ),
        title: const CustomText(
            text: "Shuttle Lounge",
            fontSize: 22,
            fontWeight: FontWeight.w600,
            textcolor: kblackColor),
        centerTitle: true,
        // actions: [
        //   GestureDetector(
        //     onTap: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => const Notifications()));
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.all(10.0),
        //       child: Image.asset(
        //         'images/notification.png',
        //         height: 25,
        //         width: 25,
        //       ),
        //     ),
        //   )
        // ],
      ),
      drawer: const CustomerSideMenu(),
      key: scaffoldKey,
      body: SafeArea(
        child: Stack(children: [
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(right: 15, left: 15),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                        margin: const EdgeInsets.only(right: 5, left: 5),
                        child: const CustomText(
                            text: "Request Review",
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            textcolor: kblackColor)),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                        margin: const EdgeInsets.only(right: 5, left: 5),
                        child: const CustomText(
                            text:
                                "Post your questions for responses from experts",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            textcolor: kblackColor)),
                    const SizedBox(
                      height: 25,
                    ),
                    const CustomText(
                        text: "Upload Youtube URL",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        textcolor: Colors.red),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: kgreyColor)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 0),
                        child: TextFormField(
                          controller: urlcontroller,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          cursorColor: Colors.red,
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    CustomText(
                        text: "Ask Expert *",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        textcolor: Colors.red),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 165,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        controller: questioncontroller,
                        minLines: 6,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        cursorColor: kblackColor,
                        decoration: InputDecoration(
                            alignLabelWithHint: true,
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            hintText: 'Ask Expert ....',
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    CustomButton(
                      text: "SUBMIT",
                      onPressed: () {
                        String youtubeUrl = urlcontroller.text.trim();
                        String questionText =
                            questioncontroller.text.toString().trim();
                        if (questionText.isNotEmpty) {
                          if (youtubeUrl.isNotEmpty) {
                            bool isValidYoutubeUrl = _validator
                                .validateYouTubeVideoURL(url: youtubeUrl);
                            if (!isValidYoutubeUrl) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Please enter a valid YouTube URL'),
                                  duration: Duration(seconds: 4),
                                ),
                              );
                              return;
                            }
                          }
                          setState(() {
                            showProgressIndicator = true;
                          });
                          data();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please ask your question'),
                              duration: Duration(seconds: 4),
                            ),
                          );
                        }
                      },
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kgreyColor,
                      textColor: kwhiteColor,
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    //    if(onSubmit = true && questioncontroller.text.toString().isNotEmpty){
                    //              data();
                    //           }
                    //          else{
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //  const SnackBar(
                    //  content: Text('Please ask your question'),
                    // duration: Duration(seconds: 4),
                    //       ),

                    //      ); }
                  ],
                ),
              ),
            ),
          ),
          if (showProgressIndicator)
            Center(
              child: ProgressBarHUD(),
            ),
        ]),
      ),
    );
  }

  Future<void> data() async {
    final CollectionReference collection =
        FirebaseFirestore.instance.collection('requestedReviews');

    final CustomModel customModel = CustomModel(
      yTUrl: urlcontroller.text.isEmpty ? "" : urlcontroller.text,
      cust_Question: questioncontroller.text,
      cust_Id: SharedPrefServices.getcustomerId().toString(),
      is_Answered: "FALSE",
      expert_queue_Id: "",
      expertAnswer: "",
      queries: [
        {
          "QuerryBy": "CUST",
          "Querry": questioncontroller.text.toString(),
        }
      ],
    );
    Map<String, dynamic> data = customModel.toMap();
    data['timestamp'] = FieldValue.serverTimestamp();
    await collection.add(data);
    setState(() {
      showProgressIndicator = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Review Submitted Successfully'),
    ));
    setState(() {
      questioncontroller.clear();
      urlcontroller.clear();
    });
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (BuildContext context) {
    //       return const CustomerHomescreen();
    //     },
    //   ),
    // );

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Dashboard()));
  }
}




  // bool isYouTubeURL(String url) {
  //   RegExp regExp = RegExp(
  //     r"(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([\w-]{11})(?:\W|$)",
  //     caseSensitive: false,
  //     multiLine: false,
  //   );
  //   return regExp.hasMatch(url);
  // }
  
  






  // Future<void> data() async {
  //   final CollectionReference collection =
  //       FirebaseFirestore.instance.collection('requestedReviews');

  //   final CustomModel customModel = CustomModel(
  //     yTUrl: urlcontroller.text.isEmpty ? "" : urlcontroller.text,
  //     cust_Question: questioncontroller.text,
  //     cust_Id: SharedPrefServices.getcustomerId().toString(),
  //     expertName: "",
  //     expertProfilepic: "",
  //     is_Answered: "FALSE",
  //     expert_queue_Id: "",
  //     expertAnswer: "",
  //     queries: [
  //       {
  //         "QuerryBy": "CUST",
  //         "Querry": questioncontroller.text.toString(),
  //       }
  //     ],
  //   );
  //   Map<String, dynamic> data = customModel.toMap();
  //   data['timestamp'] = FieldValue.serverTimestamp();
  //   await collection.add(data);
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) => Dashboard()));
  // }

  // Future<void> addData() async {
  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home()));
  // var documentId = DateTime.now().millisecondsSinceEpoch.toString();
  // var documentReference = users.doc(documentId);
  // return documentReference
  //     .set({
  //      'URL' : urlcontroller.text,
  //      'Ask Expert' : questioncontroller.text,
  //     })
  //     .then((value) => print('Data added successfully'))
  //     .catchError((error) => print('Failed to add data: $error'));}

