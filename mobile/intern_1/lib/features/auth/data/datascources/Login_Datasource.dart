import 'dart:developer';

import 'package:dio/dio.dart';

class LoginDatasource {
  final Dio dio;

  LoginDatasource({required this.dio});

  Future<Response> login({required String email, required String password}) async {
    log({"email": email, "password": password}.toString());
    final Response response = await dio.post(
      '/auth/login/',
      data: {
        "email": email,
        "password": password,
      },
    );
    return response;
  }
}
