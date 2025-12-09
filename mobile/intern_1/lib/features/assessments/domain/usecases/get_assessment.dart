import 'package:intern_1/features/assessments/domain/entities/assessment_entity.dart';
import 'package:intern_1/features/assessments/domain/repositories/get_assessment_Repository.dart';

class GetAssessment {
  GetAssessmentRepository repo;

  GetAssessment(this.repo);

  Future<AssessmentEntity> call({required int id}) async {
    return await repo.get_assessment(id: id);
  }
}
