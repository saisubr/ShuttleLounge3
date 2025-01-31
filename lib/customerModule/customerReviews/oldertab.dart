import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shuttleloungenew/const/color.dart';
import 'package:shuttleloungenew/customerModule/customerReviewFulldetails.dart';
import 'package:shuttleloungenew/providers/auth_provider.dart';
import 'package:shuttleloungenew/widgets/customtext.dart';
import 'package:shuttleloungenew/widgets/progressbar.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Oldertab extends StatefulWidget {
  const Oldertab({super.key});

  @override
  State<Oldertab> createState() => _OldertabState();
}

class _OldertabState extends State<Oldertab> {
  final CollectionReference requestedReviews =
      FirebaseFirestore.instance.collection('requestedReviews');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhiteColor,
      body: SafeArea(
        child: Center(
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
                        AuthProvider.oldertabVideodetails();

                    return FutureBuilder<List<Map<String, dynamic>>>(
                      future: videoDetailsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ProgressBarHUD();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
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
                          print(videoDetails);
                          inspect(videoDetails);
                          return ListView.builder(
                            itemCount: videoDetails.length,
                            itemBuilder: (context, index) {
                              String? videoId = YoutubePlayer.convertUrlToId(
                                      videoDetails[index]['yTUrl']
                                          .toString()) ??
                                  "";

                              Timestamp timeStamp =
                                  videoDetails[index]['timeStamp'];
                              DateTime dateTime = timeStamp.toDate();
                              String formattedTime;
                              final now = DateTime.now();
                              final difference = now.difference(dateTime);
                              if (difference.inDays > 0) {
                                formattedTime =
                                    DateFormat('d MMM').format(dateTime);
                              } else if (difference.inHours > 0) {
                                formattedTime = '${difference.inHours} hr ago';
                              } else if (difference.inMinutes > 0) {
                                formattedTime =
                                    '${difference.inMinutes} min ago';
                              } else {
                                formattedTime = 'Just now';
                              }

                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CustomerReviewFulldetails(
                                                      docId: videoDetails[index]
                                                          ["docId"],
                                                      ytUrl: videoId,
                                                      cust_ProfilePic:
                                                          videoDetails[index]
                                                              ['profilePic'],
                                                      cust_Name:
                                                          '${videoDetails[index]['firstName']} ${videoDetails[index]['lastName']}',
                                                      is_Answered:
                                                          videoDetails[index]
                                                              ['is_Answered'],
                                                      expertName:
                                                          '${videoDetails[index]['expertFirstname']} ${videoDetails[index]['expertLastname']}',
                                                      expertProfilepic:
                                                          videoDetails[index]
                                                              [
                                                              'expertProfilepic'],
                                                      queries: videoDetails[
                                                          index]['queries'])));
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      elevation: 4,
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            right: 25, left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 15,
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
                                                                  'profilePic'],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      CustomText(
                                                        text:
                                                            '${videoDetails[index]['firstName']} ${videoDetails[index]['lastName']}',
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        textcolor: kblackColor,
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 16),
                                                    child: CustomText(
                                                        text: formattedTime,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        textcolor: kGreyColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
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
                                                      child: GestureDetector(
                                                        child: YoutubePlayer(
                                                            showVideoProgressIndicator:
                                                                true,
                                                            bottomActions: [
                                                              const SizedBox(
                                                                  width: 14.0),
                                                              CurrentPosition(),
                                                              const SizedBox(
                                                                  width: 8.0),
                                                              ProgressBar(
                                                                isExpanded:
                                                                    true,
                                                              ),
                                                              const PlaybackSpeedButton(),
                                                            ],
                                                            controller:
                                                                YoutubePlayerController(
                                                              initialVideoId:
                                                                  videoId,
                                                              flags:
                                                                  const YoutubePlayerFlags(
                                                                autoPlay: false,
                                                              ),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Row(children: [
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Image.asset(
                                                "images/commenticon.png",
                                                height: 23,
                                                width: 23,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              CustomText(
                                                  text: videoDetails[index]
                                                          ['conversationCount']
                                                      .toString(),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  textcolor: kblackColor)
                                            ]),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                                videoDetails[index][
                                                                'cust_Question']
                                                            .length <=
                                                        25
                                                    ? videoDetails[index]
                                                        ['cust_Question']
                                                    : videoDetails[index][
                                                                'cust_Question']
                                                            .substring(0, 25) +
                                                        '..........',
                                                style: GoogleFonts.poppins(
                                                  color: kblackColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
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
      ),
    );
  }
}
























// import 'package:flutter/material.dart';
// import 'package:shuttlelounge/const/color.dart';
// import 'package:shuttlelounge/widgets/reviewimages_widget.dart';

// class Lastweektab extends StatelessWidget {
//   const Lastweektab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       backgroundColor: kwhiteColor,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: 30,
//             ),
//             ReviewImages(
//                 title: "Backhand grip",
//                 image: NetworkImage(
//                     "https://e4bd5yn4if9.exactdn.com/wp-content/uploads/2021/04/6-Ways-to-use-stances-in-your-badminton-movement..jpg")),
//             SizedBox(
//               height: 15,
//             ),
//             ReviewImages(
//                 title: "Forehand", image: AssetImage("images/forehand.png")),
//             SizedBox(
//               height: 15,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



























// import 'package:flutter/material.dart';
// import 'package:shuttlelounge/const/color.dart';
// import 'package:shuttlelounge/widgets/reviewimages_widget.dart';

// class Oldertab extends StatelessWidget {
//   const Oldertab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       backgroundColor: kwhiteColor,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: 30,
//             ),
//             ReviewImages(
//                 title: "Backhand grip",
//                 image: NetworkImage(
//                     "https://ichef.bbci.co.uk/onesport/cps/624/cpsprodpb/753D/production/_90731003_1200x804px-london-2012-legacy-pr-72.jpg")),
//             SizedBox(
//               height: 15,
//             ),
//             ReviewImages(
//                 title: "Slam", image: AssetImage("images/forehand.png")),
//             SizedBox(
//               height: 15,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
