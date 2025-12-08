import 'dart:developer';

import 'package:intern_1/features/core/domain/entity/assessment_entity.dart';

class AttemptModel extends AttemptEntity {
  int? id;
  String? title;
  int? score;
  int? totalScore;
  DateTime? datetime;

  AttemptModel({
    required this.id,
    required this.title,
    required this.score,
    required this.totalScore,
    required this.datetime,
  });

  factory AttemptModel.fromJson(Map<String, dynamic> json) {
    log(json.toString());
    log('json["id"].toString()');
    log(json["id"].toString());
    log(json["id"].runtimeType.toString());
    log('json["title"].toString()');
    log(json["title"].toString());
    log(json["title"].runtimeType.toString());
    log('json["score"].toString()');
    log(json["score"].toString());
    log(json["score"].runtimeType.toString());
    log('json["Total Score"].toString()');
    log(json["Total Score"].toString());
    log(json["Total Score"].runtimeType.toString());
    log('json["SubmittedAt"].toString()');
    log(json["SubmittedAt"].toString());
    log(json["SubmittedAt"].runtimeType.toString());
    return AttemptModel(
      id: json['id'],
      title: json['title'],
      score: json['score'],
      totalScore: json['Total Score'],
      datetime: DateTime.parse(json['SubmittedAt']),
    );
  }
}
