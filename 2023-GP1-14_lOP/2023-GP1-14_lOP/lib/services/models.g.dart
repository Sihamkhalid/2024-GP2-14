// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Therapist _$TherapistFromJson(Map<String, dynamic> json) => Therapist(
      name: json['Full name'] as String? ?? '',
      jobTitle: json['Job Title'] as String? ?? '',
      hospitalClinic: json['Hospital/Clinic'] as String? ?? '',
      email: json['Email'] as String? ?? '',
      password: json['Password'] as String? ?? '',
    );

Map<String, dynamic> _$TherapistToJson(Therapist instance) => <String, dynamic>{
      'Full name': instance.name,
      'Job Title': instance.jobTitle,
      'Hospital/Clinic': instance.hospitalClinic,
      'Email': instance.email,
      'Password': instance.password,
    };

Patient _$PatientFromJson(Map<String, dynamic> json) => Patient(
      name: json['Patient Name'] as String? ?? '',
      phone: json['Phone Number'] as String? ?? '',
      email: json['Email'] as String? ?? '',
      patientNum: json['Patient Number'] as String? ?? '',
      gender: json['Gender'] as String? ?? '',
      id: json['TheraID'] as String? ?? '',
    );

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'Patient Name': instance.name,
      'Phone Number': instance.phone,
      'Email': instance.email,
      'Patient Number': instance.patientNum,
      'Gender': instance.gender,
      'TheraID': instance.id,
    };

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      id: json['ID'] as String,
      Content: json['Content'] as String,
      autherID: json['AutherID'] as String,
      KeyWords: json['KeyWords'] as String,
      publishTime: json['PublishTime'],
      Title: json['Title'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'ID': instance.id,
      'Content': instance.Content,
      'AutherID': instance.autherID,
      'KeyWords': instance.KeyWords,
      'PublishTime': instance.publishTime,
      'Title': instance.Title,
      'name': instance.name,
      'image': instance.image,
    };

FAQss _$FAQssFromJson(Map<String, dynamic> json) => FAQss(
      faqId: json['FAQ ID'] as String,
      question: json['Question'] as String,
      answer: json['Answer'] as String,
    );

Map<String, dynamic> _$FAQssToJson(FAQss instance) => <String, dynamic>{
      'FAQ ID': instance.faqId,
      'Question': instance.question,
      'Answer': instance.answer,
    };

Quizz _$QuizzFromJson(Map<String, dynamic> json) => Quizz(
      questionId: json['Question ID'] as String,
      question: json['Question'] as String,
      correctAns: json['Correct Answer'] as String,
      options:
          (json['Options'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$QuizzToJson(Quizz instance) => <String, dynamic>{
      'Question ID': instance.questionId,
      'Question': instance.question,
      'Options': instance.options,
      'Correct Answer': instance.correctAns,
    };

Program _$ProgramFromJson(Map<String, dynamic> json) => Program(
      pid: json['Program ID'] as String,
      numofAct: json['NumberOfActivities'] as int,
      startDate: json['Start Date'],
      endDate: json['End Date'],
      patientNum: json['Patient Number'],
      activities:
          Program._activityListFromJson(json['Activities'] as List<dynamic>),
    );

Map<String, dynamic> _$ProgramToJson(Program instance) => <String, dynamic>{
      'Program ID': instance.pid,
      'NumberOfActivities': instance.numofAct,
      'Start Date': instance.startDate,
      'End Date': instance.endDate,
      'Patient Number': instance.patientNum,
      'Activities': instance.activities,
    };

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      activityName: json['Activity Name'] as String,
      frequency: json['Frequency'] as int,
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'Activity Name': instance.activityName,
      'Frequency': instance.frequency,
    };

Report _$ReportFromJson(Map<String, dynamic> json) => Report(
      Rid: json['Report ID'] as String,
      PatientNumber: json['Patient Number'] as String,
      ProgramID: json['Program ID'] as String,
      OverallPerformance: json['Overall Performance'] as int,
      NumberOfWeeks: json['Number of weeks'] as int,
      NumberOfIterations: json['Number of iterations'] as int,
      NumberOfActivities: json['Number of activities'] as int,
      //  ActivitiesPerformance: json['Activities Performance'] as List<dynamic>,
    );

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'Report ID': instance.Rid,
      'Patient Number': instance.PatientNumber,
      'Program ID': instance.ProgramID,
      'Overall Performance': instance.OverallPerformance,
      'Number of weeks': instance.NumberOfWeeks,
      'Number of iterations': instance.NumberOfIterations,
      'Number of activities': instance.NumberOfActivities,
      //  'Activities Performance': instance.ActivitiesPerformance,
    };
