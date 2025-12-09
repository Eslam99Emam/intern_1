import 'package:intern_1/features/assessments/domain/entities/assessment_entity.dart';
import 'package:intern_1/features/attempts/domain/entities/attempt_entity.dart';

abstract class CheckAssessmentRepository {
  Future<AttemptEntity> checkAssessment({required AssessmentEntity assessment});
}
