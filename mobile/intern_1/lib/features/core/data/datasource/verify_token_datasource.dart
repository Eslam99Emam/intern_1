import 'dart:developer';

import 'package:dio/dio.dart';

class VerifyTokenDataSource {
  Dio dio;

  VerifyTokenDataSource(this.dio);

  Future<bool> verifyToken(String token) async {
    try {
      log("token");
      log(token);
      final Response response = await dio.post(
        '/auth/verify-token/',
        data: {"token": token.toString()},
      );
      log(response.data.toString());

      if (response.data["data"]["id"] != null) return true;
      return false;
    } on DioException catch (e) {
      log("e.response!.data.toString()");
      log(e.response!.data.toString());
      return false;
    }
  }
}
