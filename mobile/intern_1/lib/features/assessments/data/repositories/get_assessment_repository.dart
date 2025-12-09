import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:intern_1/features/assessments/data/datasources/get_assessment_datasource.dart';
import 'package:intern_1/features/assessments/data/models/assessment_model.dart';
import 'package:intern_1/features/assessments/domain/entities/assessment_entity.dart';
import 'package:intern_1/features/assessments/domain/repositories/get_assessment_Repository.dart';
import 'package:intern_1/features/core/data/datasource/token_storage_ds.dart';

class GetAssessmentRepositoryIMPL implements GetAssessmentRepository {
  final GetAssessmentDatasource datasource;
  final TokenStorageDataSource token;

  GetAssessmentRepositoryIMPL(this.datasource, this.token);

  @override
  Future<AssessmentEntity> get_assessment({required int id}) async {
    final Response? response = await datasource.get_assessment(
      id: id,
      token: (await token.readToken()).toString(),
    );
    log("response!.data.toString()");
    log(response!.data["data"].toString());

    AssessmentEntity assessment = AssessmentModel.fromJson(response.data["data"]);

    log("assessment.toString()");
    log(assessment.id.toString());
    log(assessment.title.toString());
    log(assessment.duration.toString());
    log(assessment.grade.toString());
    log(assessment.questions.toString());

    return assessment;
  }
}
