import 'dart:developer';

import 'package:intern_1/features/core/data/datasource/get_subject_analysis_ds.dart';
import 'package:intern_1/features/core/domain/repository/subject_analysis_repo.dart';

class SubjectAnalysisRepoIMPL extends SubjectAnalysisRepo {
  GetSubjectAnalysisDataSource dataSource;

  SubjectAnalysisRepoIMPL(this.dataSource);

  Future<List> getSubjectAnalysis() async {
    log("repo");
    final data = await dataSource.getSubjectAnalysis();
    log('data from repo $data');
    log('"data" from repo ${data["data"]}');
    log('"data" from repo type ${data["data"].runtimeType}');
    return data["data"];
  }
}
