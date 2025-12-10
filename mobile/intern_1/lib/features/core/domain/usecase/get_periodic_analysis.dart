import 'package:intern_1/features/core/domain/repository/periodic_analysis_repo.dart';

class GetPeriodicAnalysis {
  final PeriodicAnalysisRepo repo;
  GetPeriodicAnalysis(this.repo);

  Future<Map<String, dynamic>> call() {
    return repo.getPeriodicAnalysis();
  }
}
