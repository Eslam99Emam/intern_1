import 'dart:developer';

import 'package:intern_1/features/core/data/datasource/get_history_datasource.dart';
import 'package:intern_1/features/core/data/datasource/token_storage_ds.dart';
import 'package:intern_1/features/core/data/model/assessment_model.dart';
import 'package:intern_1/features/core/domain/entity/assessment_entity.dart';
import 'package:intern_1/features/core/domain/repository/get_history_repo.dart';

class GetHistoryRepoIMPL extends GetHistoryRepo {
  final GetHistoryDatasource _getHistoryDatasource;
  final TokenStorageDataSource _storage;

  GetHistoryRepoIMPL(this._getHistoryDatasource, this._storage);
  @override
  Future<List<AttemptEntity>> getHistory() async {
    final token = await _storage.readToken();
    log("token.toString()");
    log(token.toString());
    final response = await _getHistoryDatasource.getHistory(token!);

    log("response.data.toString()");
    log(response.data.toString());

    return (response.data['data'] as List)
        .map((e) => AttemptModel.fromJson(e))
        .toList();
  }
}
