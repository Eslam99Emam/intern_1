import 'package:intern_1/features/core/domain/repository/subject_analysis_repo.dart';

class GetSubjectAnalysis {
  final SubjectAnalysisRepo repo;

  GetSubjectAnalysis(this.repo);

  Future<List> call() {
    return repo.getSubjectAnalysis();
  }
}
