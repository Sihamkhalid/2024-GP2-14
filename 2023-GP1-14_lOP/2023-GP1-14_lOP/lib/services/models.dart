//all classes that will be converted to objects

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

// Include the generated part file
part 'models.g.dart';

// JsonSerializable class for Therapist model
@JsonSerializable()
class Therapist {
  final String name;
  final String jobTitle;
  final String hospitalClinic;
  final String email;
  final String password;

  Therapist({
    this.name = '',
    this.jobTitle = '',
    this.hospitalClinic = '',
    this.email = '',
    this.password = '',
  });

  // Factory methods for JSON serialization/deserialization
  factory Therapist.fromJson(Map<String, dynamic> json) =>
      _$TherapistFromJson(json);
  Map<String, dynamic> toJson() => _$TherapistToJson(this);
}

// JsonSerializable class for Patient model
@JsonSerializable()
class Patient {
  final String name;
  final String phone;
  final String email;
  final String patientNum;
  final String gender;
  final String id;

  Patient({
    this.name = '',
    this.phone = '',
    this.email = '',
    this.patientNum = '',
    this.gender = '',
    this.id = '',
  });

  // Factory methods for JSON serialization/deserialization
  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);
  Map<String, dynamic> toJson() => _$PatientToJson(this);
}

@JsonSerializable()
class Article {
  final String id;
  final String Content;
  final String autherID;
  final String KeyWords;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final Timestamp publishTime;
  final String Title;
  final String name;
  final String image;

  Article({
    this.id = '',
    this.Content = '',
    this.KeyWords = '',
    required this.publishTime,
    this.Title = '',
    this.autherID = '',
    this.name = '',
    this.image = '',
  });

  static Timestamp _timestampFromJson(dynamic json) => json is int
      ? Timestamp.fromMillisecondsSinceEpoch(json)
      : json as Timestamp;

  static dynamic _timestampToJson(Timestamp timestamp) =>
      timestamp.millisecondsSinceEpoch;

  // Factory methods for JSON serialization/deserialization
  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}

@JsonSerializable()
class FAQss {
  final String faqId;
  final String question;
  final String answer;

  FAQss({
    required this.faqId,
    required this.question,
    required this.answer,
  });

  // Factory methods for JSON serialization/deserialization
  factory FAQss.fromJson(Map<String, dynamic> json) => _$FAQssFromJson(json);
  Map<String, dynamic> toJson() => _$FAQssToJson(this);
}

@JsonSerializable()
class Quizz {
  final String questionId;
  final String question;
  final List<String> options;
  final String correctAns;

  Quizz({
    required this.questionId,
    required this.question,
    required this.correctAns,
    required this.options,
  });

  // Factory methods for JSON serialization/deserialization
  factory Quizz.fromJson(Map<String, dynamic> json) => _$QuizzFromJson(json);
  Map<String, dynamic> toJson() => _$QuizzToJson(this);
}

@JsonSerializable()
class Program {
  final String pid;
  final int numofAct;
  final Timestamp startDate;
  final Timestamp endDate;
  final String patientNum;
  final List<Activity> activities;

  Program({
    this.pid = '',
    this.numofAct = 0,
    this.patientNum = '',
    required this.startDate,
    required this.endDate,
    required this.activities,
  });

  // Factory methods for JSON serialization/deserialization
  factory Program.fromJson(Map<String, dynamic> json) =>
      _$ProgramFromJson(json);

  Map<String, dynamic> toJson() => _$ProgramToJson(this);

  // Additional method to convert List<Activity> field
  static List<Activity> _activityListFromJson(List<dynamic> list) {
    return list.map((activityJson) => Activity.fromJson(activityJson)).toList();
  }
}

@JsonSerializable()
class Activity {
  final String activityName;
  final int frequency;

  Activity({
    this.activityName = '',
    this.frequency = 0,
  });

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}

@JsonSerializable()
class Report {
  final String Rid;
  final String PatientNumber;
  final String ProgramID;
  final int OverallPerformance;
  final int NumberOfWeeks;
  final int NumberOfIterations;
  final int NumberOfActivities;
  // final List<dynamic> ActivitiesPerformance; // Use List<dynamic> as array type

  Report({
    this.Rid = '',
    this.PatientNumber = '',
    this.ProgramID = '',
    this.OverallPerformance = 0,
    this.NumberOfWeeks = 0,
    this.NumberOfIterations = 0,
    this.NumberOfActivities = 0,
    // this.ActivitiesPerformance = const [], // Initialize with an empty array
  });

  // Factory methods for JSON serialization/deserialization
  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

  Map<String, dynamic> toJson() => _$ReportToJson(this);
}
