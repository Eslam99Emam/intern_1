import 'package:intern_1/features/core/data/datasource/get_periodic_analysis_ds.dart';
import 'package:intern_1/features/core/domain/repository/periodic_analysis_repo.dart';

class PeriodicAnalysisRepoIMPL extends PeriodicAnalysisRepo {
  final GetPeriodicAnalysisDatasource dataSource;

  PeriodicAnalysisRepoIMPL(this.dataSource);

  Future<Map<String, dynamic>> getPeriodicAnalysis() async {
    return (await dataSource.getPeriodicAnalysis())["data"];
  }
}
