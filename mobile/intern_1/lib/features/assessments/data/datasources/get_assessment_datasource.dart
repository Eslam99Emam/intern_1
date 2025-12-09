import 'package:dio/dio.dart';

class GetAssessmentDatasource {
  final Dio dio;

  GetAssessmentDatasource(this.dio);

  Future<Response?> get_assessment({
    required int id,
    required String token,
  }) async {
    final Response response = await dio.get(
      '/assessments/get/$id',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return response;
  }
}
