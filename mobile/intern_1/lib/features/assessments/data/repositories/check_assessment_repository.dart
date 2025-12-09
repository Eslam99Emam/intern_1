import 'dart:developer';

import 'package:intern_1/features/assessments/data/datasources/check_assessment_datasource.dart';
import 'package:intern_1/features/assessments/domain/entities/assessment_entity.dart';
import 'package:intern_1/features/assessments/domain/repositories/check_assessment_repository.dart';
import 'package:intern_1/features/attempts/data/models/attempt_model.dart';
import 'package:intern_1/features/attempts/domain/entities/attempt_entity.dart';
import 'package:intern_1/features/core/data/datasource/token_storage_ds.dart';

class CheckAssessmentRepositoryIMPL implements CheckAssessmentRepository {
  CheckAssessmentDatasource datasource;
  TokenStorageDataSource token;

  CheckAssessmentRepositoryIMPL(this.datasource, this.token);

  @override
  Future<AttemptEntity> checkAssessment({
    required AssessmentEntity assessment,
  }) async {
    final response = await datasource.checkAssessment(
      assessment: assessment,
      token: (await token.readToken()).toString(),
    );

    log("response!.data.toString()");
    log("data : ${response.data["data"]}");

    final AttemptEntity attempt_result = AttemptModel.fromJson(
      response.data["data"],
    );

    log("attempt_result.toString()");
    log(attempt_result.id.toString());
    log(attempt_result.score.toString());

    return attempt_result;
  }
}
