import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_1/features/core/data/datasource/get_history_datasource.dart';
import 'package:intern_1/features/core/data/datasource/token_storage_ds.dart';

import 'package:intern_1/features/core/data/datasource/verify_token_datasource.dart';
import 'package:intern_1/features/core/data/repository/get_history_repo.dart';

import 'package:intern_1/features/core/data/repository/verify_token_repo.dart';
import 'package:intern_1/features/core/domain/entity/assessment_entity.dart';
import 'package:intern_1/features/core/domain/repository/get_history_repo.dart';

import 'package:intern_1/features/core/domain/repository/verify_token_repo.dart';
import 'package:intern_1/features/core/domain/usecase/get_history.dart';

import 'package:intern_1/features/core/domain/usecase/verify_token.dart';

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
