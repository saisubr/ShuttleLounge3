import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shuttleloungenew/customerModule/statisticsscrenns/aprildata.dart';
import 'package:shuttleloungenew/customerModule/statisticsscrenns/julydata.dart';
import 'package:shuttleloungenew/customerModule/statisticsscrenns/junedata.dart';
import 'package:shuttleloungenew/customerModule/statisticsscrenns/maydata.dart';


class Statisticsscreen extends StatefulWidget {
  const Statisticsscreen({super.key});

  @override
  State<Statisticsscreen> createState() => _StatisticsscreenState();
}

class _StatisticsscreenState extends State<Statisticsscreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 4, vsync: this);
    return Scaffold(
      backgroundColor: HexColor("#FFFFFF"),
      appBar: AppBar(
        backgroundColor: HexColor("#FFFFFF"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              'images/leftarrow.png',
              height: 38,
              width: 38,
            )),
        title: Text(
          "Shuttle",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: HexColor("#000000"),
              fontFamily: 'poppins',
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                'images/menuicon.png',
                height: 35,
                width: 35,
              ))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(right: 10, left: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        "https://media.istockphoto.com/id/1270067126/photo/smiling-indian-man-looking-at-camera.jpg?s=612x612&w=0&k=20&c=ovIQ5GPurLd3mOUj82jB9v-bjGZ8updgy1ACaHMeEC0="),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Prakash Kumar",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: HexColor("#000000"),
                              fontFamily: 'poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                      Text("India, Hyderabad",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.grey.shade600,
                              fontFamily: 'poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TabBar(
                unselectedLabelColor: HexColor("#969696"),
                labelColor: HexColor("#000000"),
                labelStyle: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  color: HexColor("#000000"),
                  fontFamily: 'poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )),
                controller: tabController,
                indicatorColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 2,
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(
                    text: 'April',
                  ),
                  Tab(
                    text: 'May',
                  ),
                  Tab(
                    text: 'June',
                  ),
                  Tab(
                    text: 'July',
                  ),
                ]),
            Expanded(
                child: TabBarView(controller: tabController, children: const [
              Aprildata(),
              Maydata(),
              Junedata(),
              Julydata()
            ]))
          ],
        ),
      ),
    );
  }
}
