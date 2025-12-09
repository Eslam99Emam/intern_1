import 'dart:developer';

import 'package:intern_1/features/attempts/domain/entities/attempt_entity.dart';

class AttemptModel extends AttemptEntity {
  int? id;
  String? title;
  int? score;
  int? totalScore;
  DateTime? submittedAt;
  List<AttemptQuestionsEntity>? questions;

  AttemptModel({
    required this.id,
    required this.title,
    required this.score,
    required this.totalScore,
    required this.submittedAt,
    this.questions,
  });

  factory AttemptModel.fromJson(Map<String, dynamic> json) {
    log("json.toString()");
    log("json : $json");
    log('json["AssessmentID"].toString()');
    log(json["AssessmentID"].toString());
    log(json["AssessmentID"].runtimeType.toString());
    log('json["Title"].toString()');
    log(json["Title"].toString());
    log(json["Title"].runtimeType.toString());
    log('json["Score"].toString()');
    log(json["Score"].toString());
    log(json["Score"].runtimeType.toString());
    log('json["Total Score"].toString()');
    log(json["Total Score"].toString());
    log(json["Total Score"].runtimeType.toString());
    log('json["Questions"].toString()');
    log(json["Questions"].toString());
    log(json["Questions"].runtimeType.toString());
    return AttemptModel(
      id: json['AssessmentID'],
      title: json['Title'],
      score: json['Score'],
      totalScore: json['Total Score'],
      submittedAt: DateTime.now(),
      questions: (json['Questions'] as List)
          .map((e) => AttemptQuestionsModel.fromJson(e))
          .toList(),
    );
  }
}

class AttemptQuestionsModel extends AttemptQuestionsEntity {
  int? id;
  String? question;
  List<AttemptOptionsEntity>? options;

  AttemptQuestionsModel({
    required this.id,
    required this.question,
    required this.options,
  });

  factory AttemptQuestionsModel.fromJson(Map<String, dynamic> json) {
    return AttemptQuestionsModel(
      id: json['QuestionID'],
      question: json['Question'],
      options: (json['Options'] as List)
          .map((e) => AttemptOptionsModel.fromJson(e))
          .toList(),
    );
  }
}

class AttemptOptionsModel extends AttemptOptionsEntity {
  int? id;
  String? option;
  bool? isChosen;
  bool? isCorrect;

  AttemptOptionsModel({
    required this.id,
    required this.option,
    required this.isChosen,
    required this.isCorrect,
  });

  factory AttemptOptionsModel.fromJson(Map<String, dynamic> json) {
    return AttemptOptionsModel(
      id: json['OptionID'],
      option: json['Option'],
      isChosen: json['isChosen'],
      isCorrect: json['isCorrect'],
    );
  }
}
