import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shuttleloungenew/const/color.dart';
import 'package:shuttleloungenew/expertmodule/expert_dashboard.dart';
import 'package:shuttleloungenew/expertmodule/expertreviewstabs/expertreviewfulldetails.dart';
import 'package:shuttleloungenew/models/custom_model.dart';
import 'package:shuttleloungenew/sharedPreferences/sharedprefservices.dart';
import 'package:shuttleloungenew/widgets/custom_button.dart';
import 'package:shuttleloungenew/widgets/customtext.dart';
import 'package:shuttleloungenew/widgets/progressbar.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
class Expertresponse extends StatefulWidget {
  String ytUrl, cust_Name, cust_ProfilePic, cust_Question, docId;

  Expertresponse(
      {Key? key,
      required this.ytUrl,
      required this.cust_Name,
      required this.cust_ProfilePic,
      required this.cust_Question,
      required this.docId})
      : super(key: key);

  @override
  State<Expertresponse> createState() => _ExpertresponseState();
}

class _ExpertresponseState extends State<Expertresponse> {
  TextEditingController answercontroller = TextEditingController();
  late YoutubePlayerController controller;

  bool showProgressIndicator = false;
  List<dynamic> queries = [];

  @override
  void initState() {
    super.initState();
    String videoId = widget.ytUrl;

    if (videoId.isNotEmpty) {
      controller = YoutubePlayerController(
        initialVideoId: videoId.toString(),
        flags: const YoutubePlayerFlags(
          autoPlay: false,
        ),
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
          icon: const Icon(Icons.arrow_back_ios, color: kblackColor),
        ),
        title: const CustomText(
          text: "Expert Response",
          fontSize: 22,
          fontWeight: FontWeight.w500,
          textcolor: kblackColor,
        ),
      ),
      body: SafeArea(
        child: Stack(children: [
          Container(
            margin: const EdgeInsets.only(right: 10, left: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: kgreyColor,
                            width: 3.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(1),
                          child: CircleAvatar(
                            radius: 55.0,
                            backgroundColor: kwhiteColor,
                            backgroundImage: NetworkImage(
                              widget.cust_ProfilePic.toString(),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 25),
                      CustomText(
                        text: widget.cust_Name.toString(),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        textcolor: kblackColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _videoplay(),
                  const SizedBox(height: 15),
                  const CustomText(
                    text: "Question :",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    textcolor: kredColor,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: Linkify(
                      onOpen: (link) async {
                        if (!await launchUrl(Uri.parse(link.url))) {
                          throw Exception('Could not launch ${link.url}');
                        }
                      },
                      text: widget.cust_Question.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      linkStyle: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  // CustomText(
                  //   text: widget.cust_Question.toString(),
                  //   fontSize: 14,
                  //   fontWeight: FontWeight.w500,
                  //   textcolor: kblackColor,
                  // ),
                  const SizedBox(height: 10),
                  const CustomText(
                    text: "Response :",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    textcolor: kredColor,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 165,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: answercontroller,
                      minLines: 10,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      cursorColor: kblackColor,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: kgreyColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: kgreyColor,
                            width: 1.0,
                          ),
                        ),
                        hintText: 'Enter Response ....',
                        hintStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: "Submit Response",
                    onPressed: () {
                      if (answercontroller.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter  your response.'),
                          ),
                        );
                      } else {
                        setState(() {
                          showProgressIndicator = true;
                        });
                        updateData();
                      }
                      // updateData();
                    },
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kgreyColor,
                    textColor: kwhiteColor,
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 15),
                ],
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

  Widget _videoplay() {
    if (widget.ytUrl.isEmpty) {
      return Container();
    }

    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: YoutubePlayer(
          showVideoProgressIndicator: true,
          bottomActions: [
            const SizedBox(width: 14.0),
            CurrentPosition(),
            const SizedBox(width: 8.0),
            RemainingDuration(),
            ProgressBar(isExpanded: true),
            const PlaybackSpeedButton(),
          ],
          controller: controller,
        ),
      ),
    );
  }

  Future<void> updateData() async {
    final CollectionReference collection =
        FirebaseFirestore.instance.collection('requestedReviews');

    try {
      final String expertId = SharedPrefServices.getexpertId().toString();
      final String expertName =
          '${SharedPrefServices.getfirstname()} ${SharedPrefServices.getlastname()}';
      final String expertProfile =
          SharedPrefServices.getprofileimage().toString();

      await collection.doc(widget.docId).get().then((documentSnapshot) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        List<dynamic> queries = data['queries'] ?? [];

        queries.add({
          "QuerryBy": "EXPT",
          "Querry": answercontroller.text,
        });

        return collection.doc(widget.docId).update({
          "expertAnswer": answercontroller.text,
          "expert_queue_Id": expertId,
          "expertName": expertName,
          "expertProfile": expertProfile,
          "timestamp": FieldValue.serverTimestamp(),
          "is_Answered": "TRUE",
          "queries": queries,
        });
      }).then(
        (value) {
          updateCount();
        },
      ).catchError((e) {
        print(e);
      });
    } catch (error) {
      print("Error updating data: $error");
    } finally {
      setState(() {
        showProgressIndicator = false;
      });
    }
  }

  Future<void> updateCount() async {
    final CollectionReference collection =
        FirebaseFirestore.instance.collection('reviewCounts');

    final CountUpdateModel countUpdateModel = CountUpdateModel(
        date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
        expertId: SharedPrefServices.getexpertId().toString(),
        reviewDocId: widget.docId.toString());
    Map<String, dynamic> data = countUpdateModel.toMap();

    await collection.add(data);

    getReviewData();
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => const ExpertDashboard()),
    // );
    //  required this.ytUrl,
    //   required this.cust_Name,
    //   required this.cust_ProfilePic,
    //   required this.cust_Question,
    //   required this.docId
  }

  Future<void> getReviewData() async {
    final CollectionReference collection =
        FirebaseFirestore.instance.collection('requestedReviews');

    try {
      await collection.doc(widget.docId).get().then((documentSnapshot) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        queries = data['queries'] ?? [];
      }).then(
        (value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ExpertDashboard()),
                // builder: (context) => ExpertReviewFulldetails(
                //     cust_Name: this.widget.cust_Name,
                //     cust_ProfilePic: this.widget.cust_ProfilePic,
                //     cust_Question: this.widget.cust_Question,
                //     docId: this.widget.docId,
                //     ytUrl: this.widget.ytUrl,
                //     expert_Answer: answercontroller.text,
                //     expert_Name:
                //         "${SharedPrefServices.getfirstname()} ${SharedPrefServices.getlastname()}",
                //     expert_Profile:
                //         SharedPrefServices.getprofileimage().toString(),
                //     queries: queries)),
          );
        },
      ).catchError((e) {
        print(e);
      });
    } catch (error) {
      print("Error updating data: $error");
    }
  }
}
