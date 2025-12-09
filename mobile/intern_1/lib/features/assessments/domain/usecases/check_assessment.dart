import 'package:intern_1/features/assessments/domain/entities/assessment_entity.dart';
import 'package:intern_1/features/assessments/domain/repositories/check_assessment_repository.dart';
import 'package:intern_1/features/attempts/domain/entities/attempt_entity.dart';

class CheckAssessment {
  CheckAssessmentRepository repo;

  CheckAssessment(this.repo);

  Future<AttemptEntity> call({required AssessmentEntity assessment}) async {
    return await repo.checkAssessment(assessment: assessment);
  }
}
