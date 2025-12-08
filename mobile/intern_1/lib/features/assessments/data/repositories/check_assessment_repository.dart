import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intern_1/features/assessments/data/datascources/check_assessment_datasource.dart';
import 'package:intern_1/features/assessments/domain/repositories/login_Repository.dart';
import 'package:intern_1/features/auth/data/datascources/Login_Datasource.dart';
import 'package:intern_1/features/auth/domain/repositories/login_Repository.dart';

class CheckAssessmentRepositoryIMPL implements CheckAssessmentRepository {
  CheckAssessmentDatasource datasource;

  CheckAssessmentRepositoryIMPL(this.datasource);

  @override
  Future<bool> login({required String email, required String password}) async {
    
    return true;
  }
}
