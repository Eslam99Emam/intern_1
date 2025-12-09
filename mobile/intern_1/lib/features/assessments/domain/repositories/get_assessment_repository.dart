import 'package:intern_1/features/assessments/domain/entities/assessment_entity.dart';

abstract class GetAssessmentRepository {
  Future<AssessmentEntity> get_assessment({required int id});
}
