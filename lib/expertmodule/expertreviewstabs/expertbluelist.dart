import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:shuttleloungenew/const/color.dart';
import 'package:shuttleloungenew/expertmodule/expert_response.dart';
import 'package:shuttleloungenew/providers/auth_provider.dart';
import 'package:shuttleloungenew/widgets/customtext.dart';
import 'package:shuttleloungenew/widgets/progressbar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Mylist extends StatelessWidget {
  const Mylist({super.key});

  @override
  Widget build(BuildContext context) {
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
                      AuthProvider.expertBlueList();

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
                            'Nothing Submitted for Review',
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
                                        "HOLD") {
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
                                      // } else if (videoDetails[index]
                                      //         ['is_Answered'] ==
                                      //     "TRUE") {
                                      //   showDialog(
                                      //     context: context,
                                      //     builder: (BuildContext context) {
                                      //       return AlertDialog(
                                      //         title: const Text(
                                      //             'Review Already Answered'),
                                      //         content: const Text(
                                      //             'This review has already been answered by another expert.'),
                                      //         actions: <Widget>[
                                      //           TextButton(
                                      //             onPressed: () {
                                      //               Navigator.of(context).pop();
                                      //             },
                                      //             child: const Text('OK'),
                                      //           ),
                                      //         ],
                                      //       );
                                      //     },
                                      //   );
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
                                                  // GestureDetector(
                                                  //   onTap: () {
                                                  //     if (videoDetails[index][
                                                  //                 'is_Answered']
                                                  //             .toString() ==
                                                  //         "HOLD") {
                                                  //       showSnackBar(context,
                                                  //           "holded by an Expert");
                                                  //     }
                                                  //   },
                                                  //   child: Icon(
                                                  //     Icons.thumb_up,
                                                  //     size: 28,
                                                  //     color: videoDetails[index]
                                                  //                     [
                                                  //                     'is_Answered']
                                                  //                 .toString() ==
                                                  //             "FALSE"
                                                  //         ? kgreyColor
                                                  //         : videoDetails[index][
                                                  //                         'is_Answered']
                                                  //                     .toString() ==
                                                  //                 "TRUE"
                                                  //             ? kGreenColor
                                                  //             : videoDetails[index]
                                                  //                             [
                                                  //                             'is_Answered']
                                                  //                         .toString() ==
                                                  //                     "HOLD"
                                                  //                 ? kgreyColor
                                                  //                 : kTransparent,
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 15),
                                            videoId.isEmpty
                                                ? Container(
                                                    height: 220,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        border: Border.all(
                                                            color: kgreyColor)),
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
}
