import 'dart:developer';

import 'package:intern_1/features/assessments/domain/entities/assessment_entity.dart';

class AssessmentModel extends AssessmentEntity {
  int? id;
  String? title;
  Duration? duration;
  String? subject;
  String? grade;
  List<QuestionEntity>? questions;
  AssessmentModel({
    this.id,
    this.title,
    this.duration,
    this.subject,
    this.grade,
    this.questions,
  });

  AssessmentModel copyWith({
    int? id,
    String? title,
    Duration? duration,
    String? subject,
    String? grade,
    List<QuestionEntity>? questions,
  }) {
    return AssessmentModel(
      id: id ?? this.id,
      title: title ?? this.title,
      duration: duration ?? this.duration,
      subject: subject ?? this.subject,
      grade: grade ?? this.grade,
      questions: questions ?? this.questions,
    );
  }

  factory AssessmentModel.fromJson(Map<String, dynamic> json) {
    log("json.toString()");
    log(json.toString());
    return AssessmentModel(
      id: json["AssessmentID"],
      title: json["Title"],
      duration: _parseDuration(json["Duration"]),
      subject: json["Subject"],
      grade: json["Grade"],
      questions: (json["Questions"] as List).map((e) {
        log('json["Questions"].toString()');
        log(json["Questions"].toString());
        log(e.toString());
        return QuestionModel.fromJson(e);
      }).toList(),
    );
  }
}

Duration _parseDuration(String durationString) {
  final parts = durationString.split(':');
  final hours = int.parse(parts[0]);
  final minutes = int.parse(parts[1]);
  final seconds = int.parse(parts[2]);

  return Duration(hours: hours, minutes: minutes, seconds: seconds);
}

class QuestionModel extends QuestionEntity {
  int? id;
  String? question;
  List<OptionsEntity>? options;
  QuestionModel({this.id, this.question, this.options});

  QuestionModel copyWith({
    int? id,
    String? question,
    List<OptionsEntity>? options,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      question: question ?? this.question,
      options: options ?? this.options,
    );
  }

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
    id: json["QuestionID"],
    question: json["Question"],
    options: (json["Options"] as List)
        .map((e) => OptionsModel.fromJson(e))
        .toList(),
  );
}

class OptionsModel extends OptionsEntity {
  int? id;
  String? option;
  bool isChosen;
  OptionsModel({required this.id, required this.option, this.isChosen = false});

  OptionsModel copyWith({int? id, String? option, bool? isChosen}) {
    return OptionsModel(
      id: id ?? this.id,
      option: option ?? this.option,
      isChosen: isChosen ?? this.isChosen,
    );
  }

  factory OptionsModel.fromJson(Map<String, dynamic> json) =>
      OptionsModel(id: json["OptionID"], option: json["Option"]);
}
