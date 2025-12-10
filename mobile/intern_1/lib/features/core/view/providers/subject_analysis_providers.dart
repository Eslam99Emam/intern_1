import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_1/features/core/data/datasource/get_subject_analysis_ds.dart';
import 'package:intern_1/features/core/data/repository/subject_analysis_repo.dart';
import 'package:intern_1/features/core/domain/usecase/get_subject_analysis.dart';
import 'package:intern_1/utils/global_providers.dart';

final getSubjectAnalysisDatasourceProvider = Provider(
  (ref) => GetSubjectAnalysisDataSource(
    ref.watch(dioProvider),
    ref.watch(tokenDatasourceProvider),
  ),
);

final getSubjectAnalysisRepoProvider = Provider(
  (ref) =>
      SubjectAnalysisRepoIMPL(ref.watch(getSubjectAnalysisDatasourceProvider)),
);

final getSubjectAnalysisUsecaseProvider = Provider(
  (ref) => GetSubjectAnalysis(ref.watch(getSubjectAnalysisRepoProvider)),
);

class GetSubjectAnalysisNotifier extends AsyncNotifier<List> {
  @override
  Future<List> build() async {
    return ref.watch(getSubjectAnalysisUsecaseProvider)();
  }
}

final subjectAnalysisProvider =
    AsyncNotifierProvider.autoDispose<GetSubjectAnalysisNotifier, List>(
      GetSubjectAnalysisNotifier.new,
    );
