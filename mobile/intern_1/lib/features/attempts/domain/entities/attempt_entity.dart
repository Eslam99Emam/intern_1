abstract class AttemptEntity {
  int? id;
  String? title;
  int? score;
  int? totalScore;
  DateTime? submittedAt;
  List<AttemptQuestionsEntity>? questions;
}

class AttemptQuestionsEntity {
  int? id;
  String? question;
  List<AttemptOptionsEntity>? options;
}

class AttemptOptionsEntity {
  int? id;
  String? option;
  bool? isChosen;
  bool? isCorrect;
}
