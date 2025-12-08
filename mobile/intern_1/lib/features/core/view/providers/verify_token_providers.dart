import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intern_1/features/core/data/datasource/verify_token_datasource.dart';

import 'package:intern_1/features/core/data/repository/verify_token_repo.dart';

import 'package:intern_1/features/core/domain/repository/verify_token_repo.dart';

import 'package:intern_1/features/core/domain/usecase/verify_token.dart';

import 'package:intern_1/utils/global_providers.dart';

final splashAPIDatasourceProvider = Provider<VerifyTokenDataSource>(
  (ref) => VerifyTokenDataSource(ref.watch(dioProvider)),
);

final verifyTokenRepoProvider = Provider<VerifyTokenRepo>(
  (ref) => VerifyTokenRepoIMPL(
    ref.watch(splashAPIDatasourceProvider),
    ref.watch(tokenDatasourceProvider),
  ),
);

final verifyTokenProvider = Provider<VerifyToken>(
  (ref) => VerifyToken(ref.watch(verifyTokenRepoProvider)),
);

class VerifyTokenNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() {
    return ref.watch(verifyTokenProvider)();
  }
}

final verifyTokenNotifierProvider = AsyncNotifierProvider(
  VerifyTokenNotifier.new,
);
