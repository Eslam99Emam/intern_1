import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:intern_1/utils/Api_config.dart';

class LoginDatasource {
  final Dio dio;

  LoginDatasource({required this.dio});

  Future<Response> login({required String email, required String password}) async {
    log({"email": email, "password": password}.toString());
    final Response response = await dio.post(
      '$API_URL/auth/login/',
      data: {
        "email": email,
        "password": password,
      },
    );
    return response;
  }
}
