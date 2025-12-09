import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:intern_1/features/assessments/domain/entities/assessment_entity.dart';

class CheckAssessmentDatasource {
  final Dio dio;

  CheckAssessmentDatasource(this.dio);

  Future<Response> checkAssessment({
    required AssessmentEntity assessment,

    required String token,
  }) async {
    final data = {
      "AssessmentID": assessment.id!.toInt(),
      "answers": assessment.questions!.map((q) {
        return {
          "questionId": q.id!.toInt(),
          "chosenOptionId": q.options!.where((o) => o.isChosen).firstOrNull?.id?.toInt(),
        };
      }).toList(),
    };
    log("data.toString()");
    log(data.runtimeType.toString());
    log(data.toString());
    final Response response = await dio.post(
      '/assessments/check/',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
      data: data,
    );
    return response;
  }
}
