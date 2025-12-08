abstract class AssessmentEntity {
  int? id;
  String? title;
  Duration? duration;
  String? subject;
  String? grade;
  List<QuestionEntity>? questions;
}

abstract class QuestionEntity {
  int? id;
  String? question;
  List<OptionsEntity>? options;
}

abstract class OptionsEntity {
  int? id;
  String? option;
  bool? isChosen;
}
