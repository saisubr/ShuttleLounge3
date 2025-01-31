import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shuttleloungenew/const/color.dart';
import 'package:shuttleloungenew/expertmodule/expert_response.dart';
import 'package:shuttleloungenew/providers/auth_provider.dart';
import 'package:shuttleloungenew/sharedPreferences/sharedprefservices.dart';
import 'package:shuttleloungenew/utils/utils.dart';
import 'package:shuttleloungenew/widgets/customtext.dart';
import 'package:shuttleloungenew/widgets/progressbar.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ReviewsList extends StatefulWidget {
  const ReviewsList({super.key});

  @override
  State<ReviewsList> createState() => _ReviewsListState();
}

class _ReviewsListState extends State<ReviewsList> {
  TextEditingController answercontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: kwhiteColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Consumer<AuthProvider>(
                builder: (context, AuthProvider, _) {
                  // Fetch video details from Firestore
                  Future<List<Map<String, dynamic>>> videoDetailsFuture =
                      AuthProvider.expertGreyList();

                  return FutureBuilder<List<Map<String, dynamic>>>(
                    future: videoDetailsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ProgressBarHUD();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                          child: Text(
                            'No Requested Reviews  available',
                            style: GoogleFonts.poppins(
                                color: kblackColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      } else {
                        List<Map<String, dynamic>> videoDetails =
                            snapshot.data!;

                        return ListView.builder(
                          itemCount: videoDetails.length,
                          itemBuilder: (context, index) {
                            String? videoId = YoutubePlayer.convertUrlToId(
                                    videoDetails[index]['yTUrl'].toString()) ??
                                "";

                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (videoDetails[index]['is_Answered'] ==
                                        "FALSE") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Expertresponse(
                                              cust_Name: videoDetails[index]
                                                  ['cust_Name'],
                                              cust_ProfilePic:
                                                  videoDetails[index]
                                                      ['cust_Profilepic'],
                                              cust_Question: videoDetails[index]
                                                  ['cust_Question'],
                                              docId: videoDetails[index]
                                                  ['docId'],
                                              ytUrl: videoId,
                                            ),
                                          ));
                                    }
                                  },
                                  child: Card(
                                    color: kwhiteColor,
                                    shadowColor: kblackColor,
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: kGreyColor,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: kwhiteColor,
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 10, right: 25),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  right: 2, left: 2),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        height: 55,
                                                        width: 55,
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                color:
                                                                    kgreyColor,
                                                                width: 3.0)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(1),
                                                          child: CircleAvatar(
                                                            radius: 55.0,
                                                            backgroundColor:
                                                                kwhiteColor,
                                                            backgroundImage:
                                                                NetworkImage(
                                                              videoDetails[
                                                                      index][
                                                                  'cust_Profilepic'],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      CustomText(
                                                        text:
                                                            videoDetails[index]
                                                                ['cust_Name'],
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        textcolor: kblackColor,
                                                      ),
                                                    ],
                                                  ),
                                                  OutlinedButton(
                                                      child: const Text(
                                                        "+ Queue",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: kblackColor),
                                                      ),
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        foregroundColor:
                                                            kgreyColor,
                                                      ),
                                                      onPressed: () async {
                                                        if (videoDetails[index][
                                                                    'is_Answered']
                                                                .toString() ==
                                                            "FALSE") {
                                                          updatetoQueue(
                                                              videoDetails[
                                                                      index]
                                                                  ['docId']);
                                                        }
                                                      }),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 15),
                                            videoId.isEmpty
                                                ? Container(
                                                    height: 220,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color: kgreyColor,
                                                            width: 3.0)),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: Image.asset(
                                                        'images/forehand.png',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    height: 300,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: YoutubePlayer(
                                                          showVideoProgressIndicator:
                                                              true,
                                                          bottomActions: [
                                                            const SizedBox(
                                                                width: 14.0),
                                                            CurrentPosition(),
                                                            const SizedBox(
                                                                width: 8.0),
                                                            RemainingDuration(),
                                                            ProgressBar(
                                                              isExpanded: true,
                                                            ),
                                                            const PlaybackSpeedButton(),
                                                          ],
                                                          controller:
                                                              YoutubePlayerController(
                                                            initialVideoId:
                                                                videoId,
                                                            flags:
                                                                const YoutubePlayerFlags(
                                                                    autoPlay:
                                                                        false),
                                                          )),
                                                    ),
                                                  ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              videoDetails[index]
                                                  ['cust_Question'],
                                              style: GoogleFonts.poppins(
                                                color: kblackColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                height: 1.2,
                                              ),
                                              maxLines: 6,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            );
                          },
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updatetoQueue(String docId) async {
    final CollectionReference collection =
        FirebaseFirestore.instance.collection('requestedReviews');

    try {
      await collection.doc(docId).update({
        "is_Answered": "HOLD",
        "expert_queue_Id": SharedPrefServices.getexpertId().toString(),
      }).then(
        (value) {
          showSnackBar(context, "Review added into the Queue.");
          setState(() {});
        },
      ).catchError((e) {
        print(e);
      });

      // collection.(data);
    } catch (error) {
      print("Error adding review: $error");
    }
  }
}
