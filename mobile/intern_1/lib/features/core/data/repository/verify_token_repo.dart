import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intern_1/features/core/data/datasource/token_storage_ds.dart';
import 'package:intern_1/features/core/data/datasource/verify_token_datasource.dart';
import 'package:intern_1/features/core/domain/repository/verify_token_repo.dart';

class VerifyTokenRepoIMPL extends VerifyTokenRepo {
  final VerifyTokenDataSource api;
  final TokenStorageDataSource storage;

  VerifyTokenRepoIMPL(this.api, this.storage);

  @override
  Future<bool> verifyToken() async {
    final token = await storage.readToken();
    if (token == null) return false;
    return api.verifyToken(token);
  }
}
