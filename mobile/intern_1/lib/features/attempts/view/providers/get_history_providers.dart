import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_1/features/attempts/data/datasources/get_history_datasource.dart';
import 'package:intern_1/features/attempts/data/repositories/get_history_repo.dart';
import 'package:intern_1/features/attempts/domain/entities/attempt_entity.dart';
import 'package:intern_1/features/attempts/domain/repositories/get_history_repo.dart';
import 'package:intern_1/features/attempts/domain/usecases/get_history.dart';
import 'package:intern_1/utils/global_providers.dart';

final getHistoryDatasourceProvider = Provider<GetHistoryDatasource>(
  (ref) => GetHistoryDatasource(ref.watch(dioProvider)),
);

final getHistoryRepoProvider = Provider<GetHistoryRepo>(
  (ref) => GetHistoryRepoIMPL(
    ref.watch(getHistoryDatasourceProvider),
    ref.watch(tokenDatasourceProvider),
  ),
);

final getHistoryProvider = Provider<GetHistory>(
  (ref) => GetHistory(ref.watch(getHistoryRepoProvider)),
);

class GetHistoryNotifier extends AsyncNotifier<List<AttemptEntity>> {
  @override
  Future<List<AttemptEntity>> build() {
    return ref.watch(getHistoryProvider)();
  }
}

final getHistoryNotifierProvider = AsyncNotifierProvider.autoDispose(
  GetHistoryNotifier.new,
);
