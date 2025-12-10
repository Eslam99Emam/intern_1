import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_1/features/core/data/datasource/get_periodic_analysis_ds.dart';
import 'package:intern_1/features/core/data/repository/periodic_analysis_repo.dart';
import 'package:intern_1/features/core/domain/usecase/get_periodic_analysis.dart';
import 'package:intern_1/utils/global_providers.dart';

final getPeriodicAnalysisDatasourceProvider = Provider(
  (ref) => GetPeriodicAnalysisDatasource(
    ref.watch(dioProvider),
    ref.watch(tokenDatasourceProvider),
  ),
);

final getPeriodicAnalysisRepoProvider = Provider(
  (ref) => PeriodicAnalysisRepoIMPL(
    ref.watch(getPeriodicAnalysisDatasourceProvider),
  ),
);

final getPeriodicAnalysisUsecaseProvider = Provider(
  (ref) => GetPeriodicAnalysis(ref.watch(getPeriodicAnalysisRepoProvider)),
);

class GetPeriodicAnalysisNotifier extends AsyncNotifier<Map<String, dynamic>> {
  @override
  Future<Map<String, dynamic>> build() async {
    return await ref.watch(getPeriodicAnalysisUsecaseProvider)();
  }
}

final periodicAnalysisProvider = AsyncNotifierProvider.autoDispose<GetPeriodicAnalysisNotifier, Map<String, dynamic>>(
  GetPeriodicAnalysisNotifier.new,
);
