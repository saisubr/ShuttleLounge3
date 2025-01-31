// import 'package:flutter/material.dart';
// import 'package:shuttlelounge/const/color.dart';
// import 'package:shuttlelounge/widgets/customtext.dart';

// class Notifications extends StatefulWidget {
//   const Notifications({super.key});

//   @override
//   State<Notifications> createState() => _NotificationsState();
// }

// class _NotificationsState extends State<Notifications> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kwhiteColor,
//       appBar: AppBar(
//         elevation: 1,
//         backgroundColor: kwhiteColor,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(
//               Icons.arrow_back_ios,
//               color: kblackColor,
//             )),
//         title: const CustomText(
//             text: "Notifications",
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//             textcolor: kblackColor),
//         actions: [
//           PopupMenuButton<int>(
//             icon: const Icon(
//               Icons.more_vert,
//               color: kblackColor,
//             ),
//             itemBuilder: (context) => [
//               const PopupMenuItem(
//                   height: 30,
//                   value: 1,
//                   child: CustomText(
//                       text: "CLEAR",
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       textcolor: kblackColor)),
//             ],
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: Container(
//           margin: const EdgeInsets.only(right: 10, left: 10),
//           child: const SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 20,
//                 ),

//                 // CustomText(
//                 //     text: "CLEAR",
//                 //     fontSize: 14,
//                 //     fontWeight: FontWeight.w500,
//                 //     textcolor: kblackColor)
//                 // Container(
//                 //   decoration: BoxDecoration(
//                 //       borderRadius: BorderRadius.circular(10),
//                 //       color: kwhiteColor,
//                 //       border: Border.all(color: kgreyColor)),
//                 //   height: 80,
//                 //   width: double.infinity,
//                 //   child: Container(
//                 //     margin: const EdgeInsets.only(right: 5, left: 10),
//                 //     child: Column(
//                 //       crossAxisAlignment: CrossAxisAlignment.start,
//                 //       children: [
//                 //         const SizedBox(
//                 //           height: 10,
//                 //         ),
//                 //         Row(
//                 //           children: [
//                 //             const CircleAvatar(
//                 //               backgroundColor: kgreyColor,
//                 //               radius: 30,
//                 //               backgroundImage: NetworkImage(
//                 //                   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0K6N7uRr8HyBDTgVvMI8q422a-xOhm0ENrA&usqp=CAU"),
//                 //             ),
//                 //             const SizedBox(
//                 //               width: 15,
//                 //             ),
//                 //             Column(
//                 //               crossAxisAlignment: CrossAxisAlignment.start,
//                 //               children: [
//                 //                 const CustomText(
//                 //                     text: "Saina Nehwal",
//                 //                     fontSize: 16,
//                 //                     fontWeight: FontWeight.w500,
//                 //                     textcolor: kblackColor),
//                 //                 Text(
//                 //                   "Commented on your recent Video .",
//                 //                   style: GoogleFonts.poppins(
//                 //                     color: kblackColor,
//                 //                     fontSize: 14,
//                 //                     fontWeight: FontWeight.w400,
//                 //                   ),
//                 //                   maxLines: 2,
//                 //                 ),
//                 //                 const CustomText(
//                 //                   text: "2hrs ago",
//                 //                   fontSize: 12,
//                 //                   fontWeight: FontWeight.w500,
//                 //                   textcolor: kgreyColor,
//                 //                 )
//                 //               ],
//                 //             )
//                 //           ],
//                 //         ),
//                 //       ],
//                 //     ),
//                 //   ),
//                 // ),
//                 // const SizedBox(
//                 //   height: 15,
//                 // ),
//                 // Container(
//                 //   decoration: BoxDecoration(
//                 //       borderRadius: BorderRadius.circular(10),
//                 //       color: kwhiteColor,
//                 //       border: Border.all(color: kgreyColor)),
//                 //   height: 80,
//                 //   width: double.infinity,
//                 //   child: Container(
//                 //     margin: const EdgeInsets.only(right: 5, left: 10),
//                 //     child: Column(
//                 //       crossAxisAlignment: CrossAxisAlignment.start,
//                 //       children: [
//                 //         const SizedBox(
//                 //           height: 10,
//                 //         ),
//                 //         Row(
//                 //           children: [
//                 //             const CircleAvatar(
//                 //               backgroundColor: kgreyColor,
//                 //               radius: 30,
//                 //               backgroundImage: NetworkImage(
//                 //                   "https://t1.gstatic.com/licensed-image?q=tbn:ANd9GcSu8LGQH09-JbYXz9RywTCarn1b_u5OA5xGvkF4hibbbP1u7fYfOJPQGuP3_-9-ki_5"),
//                 //             ),
//                 //             const SizedBox(
//                 //               width: 15,
//                 //             ),
//                 //             Column(
//                 //               crossAxisAlignment: CrossAxisAlignment.start,
//                 //               children: [
//                 //                 const CustomText(
//                 //                     text: "Pullele Gopichand",
//                 //                     fontSize: 16,
//                 //                     fontWeight: FontWeight.w500,
//                 //                     textcolor: kblackColor),
//                 //                 Text(
//                 //                   "Wrote a review for your Video.",
//                 //                   style: GoogleFonts.poppins(
//                 //                     color: kblackColor,
//                 //                     fontSize: 14,
//                 //                     fontWeight: FontWeight.w400,
//                 //                   ),
//                 //                   maxLines: 2,
//                 //                 ),
//                 //                const  CustomText(
//                 //                     text: "10hrs ago",
//                 //                     fontSize: 12,
//                 //                     fontWeight: FontWeight.w500,
//                 //                     textcolor: kgreyColor),
//                 //               ],
//                 //             )
//                 //           ],
//                 //         ),
//                 //       ],
//                 //     ),
//                 //   ),
//                 // ),
//                 // const SizedBox(
//                 //   height: 15,
//                 // ),
//                 // Container(
//                 //   decoration: BoxDecoration(
//                 //       borderRadius: BorderRadius.circular(10),
//                 //       color: kwhiteColor,
//                 //       border: Border.all(color: kgreyColor)),
//                 //   height: 80,
//                 //   width: double.infinity,
//                 //   child: Container(
//                 //     margin: const EdgeInsets.only(right: 5, left: 10),
//                 //     child: Column(
//                 //       crossAxisAlignment: CrossAxisAlignment.start,
//                 //       children: [
//                 //         const SizedBox(
//                 //           height: 10,
//                 //         ),
//                 //         Row(
//                 //           children: [
//                 //             const CircleAvatar(
//                 //               backgroundColor: kgreyColor,
//                 //               radius: 30,
//                 //               backgroundImage: NetworkImage(
//                 //                   "https://upload.wikimedia.org/wikipedia/commons/7/73/PV_Sindhu_headshot.jpg"),
//                 //             ),
//                 //             const SizedBox(
//                 //               width: 15,
//                 //             ),
//                 //             Column(
//                 //               crossAxisAlignment: CrossAxisAlignment.start,
//                 //               children: [
//                 //                 const CustomText(
//                 //                     text: "PV Sindhu",
//                 //                     fontSize: 16,
//                 //                     fontWeight: FontWeight.w500,
//                 //                     textcolor: kblackColor),
//                 //                 Text(
//                 //                   "Share a video for your question.",
//                 //                   style: GoogleFonts.poppins(
//                 //                     color: kblackColor,
//                 //                     fontSize: 14,
//                 //                     fontWeight: FontWeight.w400,
//                 //                   ),
//                 //                   maxLines: 2,
//                 //                 ),
//                 //                 const CustomText(
//                 //                     text: "1 day ago",
//                 //                     fontSize: 12,
//                 //                     fontWeight: FontWeight.w500,
//                 //                     textcolor: kgreyColor),
//                 //               ],
//                 //             )
//                 //           ],
//                 //         ),
//                 //       ],
//                 //     ),
//                 //   ),
//                 // ),
//                 // const SizedBox(
//                 //   height: 15,
//                 // ),
//                 // Container(
//                 //   decoration: BoxDecoration(
//                 //       borderRadius: BorderRadius.circular(10),
//                 //       color: kwhiteColor,
//                 //       border: Border.all(color: kgreyColor)),
//                 //   height: 80,
//                 //   width: double.infinity,
//                 //   child: Container(
//                 //     margin: const EdgeInsets.only(right: 5, left: 10),
//                 //     child: Column(
//                 //       crossAxisAlignment: CrossAxisAlignment.start,
//                 //       children: [
//                 //         const SizedBox(
//                 //           height: 10,
//                 //         ),
//                 //         Row(
//                 //           children: [
//                 //             const CircleAvatar(
//                 //               backgroundColor: kgreyColor,
//                 //               radius: 30,
//                 //               backgroundImage: NetworkImage(
//                 //                   "https://upload.wikimedia.org/wikipedia/commons/6/60/Prakash_Padukone_at_the_Tata_Open_championship.JPG"),
//                 //             ),
//                 //             const SizedBox(
//                 //               width: 15,
//                 //             ),
//                 //             Column(
//                 //               crossAxisAlignment: CrossAxisAlignment.start,
//                 //               children: [
//                 //                 const CustomText(
//                 //                     text: "Prakash Padukone",
//                 //                     fontSize: 16,
//                 //                     fontWeight: FontWeight.w500,
//                 //                     textcolor: kblackColor),
//                 //                 Text(
//                 //                   "Added a URL to your Video. ",
//                 //                   style: GoogleFonts.poppins(
//                 //                     color: kblackColor,
//                 //                     fontSize: 14,
//                 //                     fontWeight: FontWeight.w400,
//                 //                   ),
//                 //                   maxLines: 2,
//                 //                 ),
//                 //                const  CustomText(
//                 //                   text: "Aug 22 at 4:30 PM",
//                 //                   fontSize: 12,
//                 //                   fontWeight: FontWeight.w500,
//                 //                   textcolor: kgreyColor,
//                 //                 )
//                 //               ],
//                 //             )
//                 //           ],
//                 //         ),
//                 //       ],
//                 //     ),
//                 //   ),
//                 // ),
//                 // const SizedBox(
//                 //   height: 15,
//                 // ),
//                 // Container(
//                 //   decoration: BoxDecoration(
//                 //       borderRadius: BorderRadius.circular(10),
//                 //       color: kwhiteColor,
//                 //       border: Border.all(color: kgreyColor)),
//                 //   height: 80,
//                 //   width: double.infinity,
//                 //   child: Container(
//                 //     margin: const EdgeInsets.only(right: 5, left: 10),
//                 //     child: Column(
//                 //       crossAxisAlignment: CrossAxisAlignment.start,
//                 //       children: [
//                 //         const SizedBox(
//                 //           height: 10,
//                 //         ),
//                 //         Row(
//                 //           children: [
//                 //             const CircleAvatar(
//                 //               backgroundColor: kgreyColor,
//                 //               radius: 30,
//                 //               backgroundImage: NetworkImage(
//                 //                   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZPVmc3_MulFbEKNASJcIlzX6gLoZ_dudBeBBcnRuYY4LMbZ_8w0ZBl-WjMA94uhjGpGo&usqp=CAU"),
//                 //             ),
//                 //             const SizedBox(
//                 //               width: 15,
//                 //             ),
//                 //             Column(
//                 //               crossAxisAlignment: CrossAxisAlignment.start,
//                 //               children: [
//                 //                 const CustomText(
//                 //                     text: "Srikanth Kidambi",
//                 //                     fontSize: 16,
//                 //                     fontWeight: FontWeight.w500,
//                 //                     textcolor: kblackColor),
//                 //                 Text(
//                 //                   "Commented on your video.",
//                 //                   style: GoogleFonts.poppins(
//                 //                     color: kblackColor,
//                 //                     fontSize: 14,
//                 //                     fontWeight: FontWeight.w400,
//                 //                   ),
//                 //                   maxLines: 2,
//                 //                 ),
//                 //                const  CustomText(
//                 //                     text: "Aug 18 at 6:30 PM",
//                 //                     fontSize: 12,
//                 //                     fontWeight: FontWeight.w500,
//                 //                     textcolor: kgreyColor),
//                 //               ],
//                 //             )
//                 //           ],
//                 //         ),
//                 //       ],
//                 //     ),
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
