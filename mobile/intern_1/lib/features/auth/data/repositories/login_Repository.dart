import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intern_1/features/auth/data/datascources/Login_Datasource.dart';
import 'package:intern_1/features/auth/domain/repositories/login_Repository.dart';

class LoginRepositoryIMPL implements LoginRepository {
  LoginDatasource datasource;

  LoginRepositoryIMPL(this.datasource);

  @override
  Future<bool> login({required String email, required String password}) async {
    final Response? response = await datasource.login(
      email: email,
      password: password,
    );

    log(response!.data.toString());
    log("response.data['token'].toString()");
    log(response.data['token'].toString());

    final storage = const FlutterSecureStorage();

    await storage.write(key: 'token', value: response.data['token']);
    
    return true;
  }
}
