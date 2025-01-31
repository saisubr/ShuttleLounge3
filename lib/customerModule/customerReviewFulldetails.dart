import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shuttleloungenew/const/color.dart';
import 'package:shuttleloungenew/customerModule/bottomNavigationBarScreens/dashboard.dart';
import 'package:shuttleloungenew/widgets/customtext.dart';
import 'package:shuttleloungenew/widgets/progressbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

class CustomerReviewFulldetails extends StatefulWidget {
  String ytUrl,
      cust_ProfilePic,
      cust_Name,
      expertName,
      expertProfilepic,
      docId,
      is_Answered;
  List queries;

  CustomerReviewFulldetails(
      {Key? key,
      required this.ytUrl,
      required this.cust_ProfilePic,
      required this.cust_Name,
      required this.is_Answered,
      required this.expertName,
      required this.docId,
      required this.expertProfilepic,
      required this.queries})
      : super(key: key);

  @override
  State<CustomerReviewFulldetails> createState() =>
      _CustomerReviewFulldetailsState();
}

class _CustomerReviewFulldetailsState extends State<CustomerReviewFulldetails> {
  late YoutubePlayerController controller;
  TextEditingController custController = TextEditingController();

  bool showProgressIndicator = false;

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
          elevation: 0,
          centerTitle: true,
          backgroundColor: kwhiteColor,
          title: const CustomText(
              text: "Requested Reviews",
              fontSize: 20,
              fontWeight: FontWeight.w600,
              textcolor: kblackColor),
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Dashboard()),
              );
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: kblackColor,
              size: 22,
            ),
          ),
        ),
        body: SafeArea(
            child: Stack(children: [
          Container(
            margin: const EdgeInsets.only(right: 15, left: 15),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                widget.ytUrl.isEmpty
                    ? Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: kgreyColor)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'images/forehand.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : _videoplay(),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.queries.length,
                    itemBuilder: (context, index) {
                      return widget.queries[index]["QuerryBy"].toString() ==
                              "CUST"
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      top: 5,
                                      bottom: 5,
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(20)),
                                        color: Colors.grey[300]),
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              alignment: Alignment.centerLeft,
                                              child: CustomText(
                                                  text: widget.cust_Name,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  textcolor: kblackColor)),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          // SizedBox(
                                          //     child: CustomText(
                                          //         text: widget.queries[index]
                                          //                 ['Querry']
                                          //             .toString(),
                                          //         fontSize: 14,
                                          //         fontWeight: FontWeight.w500,
                                          //         textcolor: kblackColor)),
                                          SizedBox(
                                            child: Linkify(
                                              onOpen: (link) async {
                                                if (!await launchUrl(
                                                    Uri.parse(link.url))) {
                                                  throw Exception(
                                                  'Could not launch ${link.url}');
                                                }
                                              },
                                              text: widget.queries[index]
                                                      ['Querry']
                                                  .toString(),
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
                                          const SizedBox(
                                            height: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20, left: 5),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      widget.cust_ProfilePic.toString(),
                                    ),
                                    radius: 25,
                                  ),
                                ),
                              ],
                            )
                          : Container(
                              margin: const EdgeInsets.only(
                                top: 5,
                                bottom: 5,
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              widget.expertProfilepic),
                                          radius: 25,
                                        ),
                                        Positioned(
                                            top: 35,
                                            left: 35,
                                            child: Container(
                                              height: 15,
                                              width: 15,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: kblackColor,
                                                      width: 2.0),
                                                  color: kgreyColor,
                                                  shape: BoxShape.circle),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.check,
                                                  color: kwhiteColor,
                                                  size: 10,
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20)),
                                          color: Colors.red[100]),
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              widget.expertName,
                                              style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                color: kblackColor,
                                                fontFamily: 'poppins',
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              )),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            SizedBox(
                                            child: Linkify(
                                              onOpen: (link) async {
                                                if (!await launchUrl(
                                                    Uri.parse(link.url))) {
                                                  throw Exception(
                                                  'Could not launch ${link.url}');
                                                }
                                              },
                                              text: widget.queries[index]
                                                      ['Querry']
                                                  .toString(),
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
                                            const SizedBox(
                                              height: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: custController,
                            minLines: 2,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            cursorColor: kblackColor,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 15, top: 15),
                              border: InputBorder.none,
                              alignLabelWithHint: true,
                              hintText: 'Ask Expert ....',
                              hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (custController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please ask your question.'),
                                ),
                              );
                            } else {
                              setState(() {
                                showProgressIndicator = true;
                              });
                              updateList();
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                              right: 20,
                            ),
                            child: Image.asset(
                              "images/shareicon.png",
                              height: 25,
                              width: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
              ],
            ),
          ),
          if (showProgressIndicator)
            Center(
              child: ProgressBarHUD(),
            ),
        ])));
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

  Future<void> updateList() async {
    final CollectionReference collection =
        FirebaseFirestore.instance.collection('requestedReviews');

    try {
      await collection.doc(widget.docId).get().then((documentSnapshot) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        List<dynamic> queries = data['queries'] ?? [];

        queries.add({
          "QuerryBy": "CUST",
          "Querry": custController.text,
        });

        return collection.doc(widget.docId).update({
          "queries": queries,
        });
      }).then(
        (value) {
          setState(() {
            showProgressIndicator = false;
          });

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Dashboard()));
        },
      ).catchError((e) {
        print(e);
      });
    } catch (error) {
      print("Error updating data: $error");
    }
  }
}
