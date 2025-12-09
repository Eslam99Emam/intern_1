import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_1/features/assessments/data/datasources/check_assessment_datasource.dart';
import 'package:intern_1/features/assessments/data/repositories/check_assessment_repository.dart';
import 'package:intern_1/features/assessments/domain/entities/assessment_entity.dart';
import 'package:intern_1/features/assessments/domain/usecases/check_assessment.dart';
import 'package:intern_1/features/attempts/domain/entities/attempt_entity.dart';
import 'package:intern_1/utils/global_providers.dart';

final checkAssessmentDatasourceProvider = Provider(
  (ref) => CheckAssessmentDatasource(ref.read(dioProvider)),
);

final checkAssessmentRepositoryProvider = Provider((ref) {
  return CheckAssessmentRepositoryIMPL(
    ref.read(checkAssessmentDatasourceProvider),
    ref.read(tokenDatasourceProvider),
  );
});

final checkAssessmentUseCaseProvider = Provider((ref) {
  return CheckAssessment(ref.read(checkAssessmentRepositoryProvider));
});

final checkAssessment = FutureProvider.family<AttemptEntity, AssessmentEntity>((
  ref,
  assessment,
) {
  log("checkAssessment");
  return ref.read(checkAssessmentUseCaseProvider)(assessment: assessment);
});
