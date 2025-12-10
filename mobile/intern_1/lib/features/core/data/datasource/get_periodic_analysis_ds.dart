import 'package:dio/dio.dart';
import 'package:intern_1/features/core/data/datasource/token_storage_ds.dart';

class GetPeriodicAnalysisDatasource {
  final Dio dio;
  final TokenStorageDataSource token;

  GetPeriodicAnalysisDatasource(this.dio, this.token);

  Future<Map<String, dynamic>> getPeriodicAnalysis() async {
    final response = await dio.get(
      '/period-scores-analysis/',
      options: Options(
        headers: {"Authorization": "Bearer ${await token.readToken()}"},
      ),
    );

    return response.data;
  }
}
