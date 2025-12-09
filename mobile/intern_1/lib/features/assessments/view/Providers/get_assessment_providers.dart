import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_1/features/assessments/data/datasources/get_assessment_datasource.dart';
import 'package:intern_1/features/assessments/data/models/assessment_model.dart';
import 'package:intern_1/features/assessments/data/repositories/get_assessment_repository.dart';
import 'package:intern_1/features/assessments/domain/entities/assessment_entity.dart';
import 'package:intern_1/features/assessments/domain/usecases/get_assessment.dart';
import 'package:intern_1/utils/global_providers.dart';

final getAssessmentDatasourceProvider = Provider(
  (ref) => GetAssessmentDatasource(ref.read(dioProvider)),
);

final getAssessmentRepositoryProvider = Provider((ref) {
  return GetAssessmentRepositoryIMPL(
    ref.read(getAssessmentDatasourceProvider),
    ref.read(tokenDatasourceProvider),
  );
});

final getAssessmentUseCaseProvider = Provider((ref) {
  return GetAssessment(ref.read(getAssessmentRepositoryProvider));
});

class GetAssessmentNotifier extends AsyncNotifier<AssessmentEntity> {
  GetAssessmentNotifier(int this.id);
  final int id;

  @override
  Future<AssessmentEntity> build() async {
    return await ref.read(getAssessmentUseCaseProvider)(id: id);
  }

  void setAnswer(int QuestionId, int AnswerId) {
    log("setAnswer 1");
    log(QuestionId.toString());
    log(AnswerId.toString());
    if (state.hasValue) {
      log("setAnswer 2");
      AssessmentEntity assessment = state.value!;
      AssessmentModel new_assessment = AssessmentModel(
        id: assessment.id,
        title: assessment.title,
        duration: assessment.duration,
        grade: assessment.grade,
        questions: assessment.questions!.map((q) {
          if (q.id == QuestionId) {
            q.options = q.options!.map((o) {
              if (o.id == AnswerId) {
                o.isChosen = true;
              } else {
                o.isChosen = false;
              }
              return o;
            }).toList();
          }
          return q;
        }).toList(),
      );
      log("assessment.toString() 1");
      log(
        assessment
            .questions![(QuestionId - 1) % assessment.questions!.length]
            .options!
            .map((o) => o.isChosen)
            .toString(),
      );
      log("assessment.toString() 2");
      log(
        new_assessment
            .questions![(QuestionId - 1) % assessment.questions!.length]
            .options!
            .map((o) => o.isChosen)
            .toString(),
      );
      state = AsyncValue.data(new_assessment);
    }
  }
}

final getAssessment =
    AsyncNotifierProvider.autoDispose.family<GetAssessmentNotifier, AssessmentEntity, int>(
      GetAssessmentNotifier.new,
    );
