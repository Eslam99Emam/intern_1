import 'package:dio/dio.dart';
import 'package:intern_1/features/core/data/datasource/token_storage_ds.dart';

class GetSubjectAnalysisDataSource {
  final Dio dio;
  final TokenStorageDataSource token;

  GetSubjectAnalysisDataSource(this.dio, this.token);

  Future<Map<String, dynamic>> getSubjectAnalysis() async {
    final response = await dio.get(
      '/subject-scores-analysis/',
      options: Options(
        headers: {"Authorization": "Bearer ${await token.readToken()}"},
      ),
    );

    return response.data;
  }
}
