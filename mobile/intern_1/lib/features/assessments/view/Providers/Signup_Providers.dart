import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_1/features/auth/data/datascources/Signup_Datasource.dart';
import 'package:intern_1/features/auth/data/repositories/signup_Repository.dart';
import 'package:intern_1/features/auth/domain/usecases/Signup.dart';

final signupNameControllerProvider = Provider.autoDispose(
  (ref) => TextEditingController(),
);

final signupEmailControllerProvider = Provider.autoDispose(
  (ref) => TextEditingController(),
);

final signupPhoneControllerProvider = Provider.autoDispose(
  (ref) => TextEditingController(),
);

final signupGradeControllerProvider = Provider.autoDispose(
  (ref) => TextEditingController(text: "G13"),
);

final signupPasswordControllerProvider = Provider.autoDispose(
  (ref) => TextEditingController(),
);

final dioProvider = Provider((ref) => Dio());

final signupDatasourceProvider = Provider(
  (ref) => SignupDatasource(ref.read(dioProvider)),
);

final signupRepositoryProvider = Provider((ref) {
  return SignUpRepositoryIMPL(ref.read(signupDatasourceProvider));
});

final signupUseCaseProvider = Provider((ref) {
  return Signup(ref.read(signupRepositoryProvider));
});
