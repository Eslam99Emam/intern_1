import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_1/features/auth/data/datascources/Login_Datasource.dart';
import 'package:intern_1/features/auth/data/repositories/login_Repository.dart';
import 'package:intern_1/features/auth/domain/usecases/Login.dart';
import 'package:intern_1/utils/global_providers.dart';


final loginEmailControllerProvider = Provider.autoDispose(
  (ref) => TextEditingController(),
);
final loginPasswordControllerProvider = Provider.autoDispose(
  (ref) => TextEditingController(),
);
final loginDatasourceProvider = Provider(
  (ref) => LoginDatasource(dio: ref.read(dioProvider)),
);

final loginRepositoryProvider = Provider((ref) {
  return LoginRepositoryIMPL(ref.read(loginDatasourceProvider));
});

final loginUseCaseProvider = Provider((ref) {
  return Login(ref.read(loginRepositoryProvider));
});
