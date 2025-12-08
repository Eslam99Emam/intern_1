import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intern_1/features/auth/data/datascources/Signup_Datasource.dart';
import 'package:intern_1/features/auth/domain/entities/User_Entity.dart';
import 'package:intern_1/features/auth/domain/repositories/signup_Repository.dart';

class SignUpRepositoryIMPL implements SignUpRepository {
  final SignupDatasource datasource;

  SignUpRepositoryIMPL(this.datasource);

  @override
  Future signUp({required UserEntity user}) async {
    final Response? response = await datasource.signUp(
      name: user.name,
      email: user.email,
      phone: user.phone,
      grade: user.grade,
      password: user.password,
    );
    log(response!.data.toString());

    final storage = const FlutterSecureStorage();

    await storage.write(
      key: 'token',
      value: response.data['token'],
      iOptions: IOSOptions(accessibility: .first_unlock),
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
  }
}
