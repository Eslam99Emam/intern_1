import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:intern_1/features/core/data/datasource/token_storage_ds.dart';

class GetProfileDataSource {
  final Dio dio;
  final TokenStorageDataSource token;

  GetProfileDataSource(this.dio, this.token);

  Future<Map<String, dynamic>> getProfile() async {
    final Response response = await dio.get(
      '/get-profile/',
      options: Options(
        headers: {"Authorization": "Bearer ${await token.readToken()}"},
      ),
    );
    log("response ${response.data}");
    log("response ${response.data.runtimeType}");
    return response.data;
  }
}
