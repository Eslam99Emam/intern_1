import 'package:dio/dio.dart';

class GetHistoryDatasource {
  final Dio dio;

  GetHistoryDatasource(this.dio);

  Future<Response> getHistory(String token) async {
    final Response response = await dio.get(
      '/history/',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response;
  }
}
