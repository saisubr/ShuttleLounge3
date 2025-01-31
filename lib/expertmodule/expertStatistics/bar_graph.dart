import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shuttleloungenew/sharedPreferences/sharedprefservices.dart';
import 'package:shuttleloungenew/widgets/verticalbars.dart';

// import 'package:vertical_percent_indicator/vertical_percent_indicator.dart';

class BarChartSample extends StatefulWidget {
  @override
  State<BarChartSample> createState() => _BarChartSampleState();
}

class _BarChartSampleState extends State<BarChartSample> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  List<String> dayNames = [];
  List<String> datesList = [];
  List<int> countList = [];

  @override
  void initState() {
    super.initState();
    generateDates();
    dayNames = getDayNames();
  }

  List<String> getDayNames() {
    DateTime now = DateTime.now();
    List<String> days = ['M', 'T', 'W', 'TH', 'F', 'S', 'SU'];
    int currentDayIndex = now.weekday;

    List<String> dayNames = [];

    for (int i = currentDayIndex; i < days.length; i++) {
      dayNames.add(days[i]);
    }

    for (int i = 0; i < currentDayIndex; i++) {
      dayNames.add(days[i]);
    }
    return dayNames;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        7,
        (index) => Verticalbars(
          height: 150,
          width: 5,
          percent: countList.isEmpty ? 0.0 : countList[index] / 10,
          header: '${countList.isEmpty ? 0 : countList[index]}',
          footer: dayNames[index],
        ),
      ),
    );
  }

  void generateDates() {
    
    DateTime currentDate = DateTime.now();
    for (int i = 0; i < 7; i++) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(currentDate);
      currentDate = currentDate.subtract(const Duration(days: 1));
      datesList.insert(0, formattedDate);
    }
    print('Now Priniting Dates Bar Graph');
    print(datesList);
    getReviewCounts();
  }
Future<List<Map<String, dynamic>>> getReviewCounts() async {
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection('reviewCounts')
          .where('expertId', isEqualTo: SharedPrefServices.getexpertId())
          .get();

      List<Map<String, dynamic>> reviewCount = querySnapshot.docs.map((doc) {
        return {
          'date': doc['date'],
          'expertId': doc['expertId'],
          'reviewDocId': doc['reviewDocId'],
        };
      }).toList();

      countList = List<int>.filled(datesList.length, 0);

      for (var count in reviewCount) {
        String? date = count['date'];
        int index = datesList.indexOf(date!);
        if (index != -1) {
          countList[index]++;
        }
      }
      print('Printing Counts:');
      print(countList);

      setState(() {});

      print('Printing Data:');
      print(reviewCount);


      return reviewCount;
    } catch (error) {
      print("Error fetching reviewsCount: $error");
      return [];
    }
  }
}

  



  





// fetchGivenReviewsCount() async {
//   try {
//     QuerySnapshot querySnapshot = await _firebaseFirestore
//         .collection('requestedReviews')
//         .where('expert_queue_Id', isEqualTo: SharedPrefServices.getexpertId())
//         .where("is_Answered", isEqualTo: "TRUE")
//         .orderBy('timestamp', descending: true)
//         .get();

//     List<int> reviewCountsByDay = getReviewCountsByDay(querySnapshot);

//     setState(() {
//       for (int i = 0; i < reviewCountsByDay.length; i++) {
//         percentages[i] = reviewCountsByDay[i].toDouble();
//       }
//     });
//   } catch (error) {
//     print("Error fetching reviews: $error");
//   }
// }

// List<int> getReviewCountsByDay(QuerySnapshot querySnapshot) {
//   List<int> reviewCountsByDay = List<int>.filled(7, 0);

//   List dummy = [];

//   for (var doc in querySnapshot.docs) {
//     DateTime timestamp = (doc['timestamp'] as Timestamp).toDate();
//     int dayIndex = timestamp.weekday - 1;
//     if (dayIndex >= 0 && dayIndex < 7) {
//       reviewCountsByDay[dayIndex]++;
//       dummy.add({" weekday": timestamp, "count": dayIndex});
//     }
//   }

//   // print('Now printing reviewscountby day');
//   // print(reviewCountsByDay);
//   // inspect(reviewCountsByDay);
//   // print('Now printing dummy list');
//   // print(dummy);
//   // inspect(dummy);
//   return reviewCountsByDay;
// }
