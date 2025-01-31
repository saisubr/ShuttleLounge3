// import 'package:json_annotation/json_annotation.dart';

// class CustomModel {
//   String yTUrl;
//   String cust_Id;
//   String cust_Question;
//   String is_Answered;
//   String expertName;
//   String expertProfilepic;
//   String expert_queue_Id;
//   String expertAnswer;
//   final List<Map<String, dynamic>> queries;
//   CustomModel({
//     required this.yTUrl,
//     required this.cust_Id,
//     required this.cust_Question,
//     required this.expertName,
//     required this.expertProfilepic,
//     required this.queries,
//     required this.is_Answered,
//     required this.expert_queue_Id,
//     required this.expertAnswer,
//   });

//   // from map
//   factory CustomModel.fromMap(Map<String, dynamic> map) {
//     return CustomModel(
//       yTUrl: map['yTUrl'] ?? '',
//       cust_Id: map['cust_Id'] ?? '',
//       cust_Question: map['cust_Question'] ?? '',
//       expertName: map['expertName'] ?? '',
//       expertProfilepic: map['expertProfilepic'] ?? '',
//       is_Answered: map['is_Answered'] ?? '',
//       expert_queue_Id: "",
//       expertAnswer: "",
//       queries: [],
//     );
//   }

//   // to map
//   Map<String, dynamic> toMap() {
//     return {
//       "yTUrl": yTUrl,
//       "cust_Id": cust_Id,
//       "cust_Question": cust_Question,
//       "expertName": expertName,
//       "expertProfilepic": expertProfilepic,
//       "is_Answered": is_Answered,
//       "expert_queue_Id": "",
//       "expertAnswer": "",
//       'queries': queries,
//     };
//   }
// }

// //creating model for querries

// @JsonSerializable()
// class querrieModel {
//   String QuerryBy;

//   String Querry;

//   querrieModel({
//     this.QuerryBy = '',
//     this.Querry = '',
//   });

//   factory querrieModel.fromJson(Map<String, dynamic> json) =>
//       _$querrieModelFromJson(json);
//   Map<String, dynamic> toJson() => _$querrieModelToJson(this);
// }

// querrieModel _$querrieModelFromJson(Map<String, dynamic> json) {
//   return querrieModel(
//     QuerryBy: (json['data'] as String),
//     Querry: (json['data'] as String),
//   );
// }

// Map<String, dynamic> _$querrieModelToJson(querrieModel instance) =>
//     <String, dynamic>{
//       'QuerryBy': instance.QuerryBy,
//       'Querry': instance.Querry,
//     };

class CustomModel {
  String yTUrl;
  String cust_Id;
  String cust_Question;
  String is_Answered;
  String expert_queue_Id;
  String expertAnswer;
  final List<Map<String, dynamic>> queries;
  CustomModel({
    required this.yTUrl,
    required this.cust_Id,
    required this.cust_Question,
    required this.queries,
    required this.is_Answered,
    required this.expert_queue_Id,
    required this.expertAnswer,
  });

  // from map
  factory CustomModel.fromMap(Map<String, dynamic> map) {
    return CustomModel(
      yTUrl: map['yTUrl'] ?? '',
      cust_Id: map['cust_Id'] ?? '',
      cust_Question: map['cust_Question'] ?? '',
      is_Answered: map['is_Answered'] ?? '',
      expert_queue_Id: "",
      expertAnswer: "",
      queries: [],
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "yTUrl": yTUrl,
      "cust_Id": cust_Id,
      "cust_Question": cust_Question,
      "is_Answered": is_Answered,
      "expert_queue_Id": "",
      "expertAnswer": "",
      'queries': queries,
    };
  }
}

class CountUpdateModel {
  String date;
  String expertId;
  String reviewDocId;

  CountUpdateModel({
    required this.date,
    required this.expertId,
    required this.reviewDocId,
  });

  // from map
  factory CountUpdateModel.fromMap(Map<String, dynamic> map) {
    return CountUpdateModel(
      date: map['date'] ?? '',
      expertId: map['expertId'] ?? '',
      reviewDocId: map['reviewDocId'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "date": date,
      "expertId": expertId,
      "reviewDocId": reviewDocId,
    };
  }
}
