
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:intern_1/utils/Api_config.dart';

class SignupDatasource {
  final Dio dio;

  SignupDatasource(this.dio);

  Future<Response?> signUp({
    required String name,
    required String email,
    required String phone,
    required String grade,
    required String password,
  }) async {
    log(
      {
        "name": name,
        "email": email,
        "phone": phone,
        "grade": grade,
        "password": password,
        "role": "Student",
      }.toString(),
    );
    final Response response = await dio.post(
      '$API_URL/auth/signup/',
      data: {
        "name": name,
        "email": email,
        "phone": phone,
        "grade": grade,
        "password": password,
        "role": "Student",
      },
    );
    return response;
  }
}
