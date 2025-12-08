import 'package:intern_1/features/assessments/domain/entities/assessment_entity.dart';
import 'package:intern_1/features/auth/domain/entities/User_Entity.dart';

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
}
