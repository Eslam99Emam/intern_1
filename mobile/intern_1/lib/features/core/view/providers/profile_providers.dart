import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_1/features/core/data/datasource/get_profile_datasource.dart';
import 'package:intern_1/features/core/data/repository/profile_repo.dart';
import 'package:intern_1/features/core/domain/usecase/get_profile.dart';
import 'package:intern_1/utils/global_providers.dart';

final getProfileDatasourceProvider = Provider((ref) {
  return GetProfileDataSource(
    ref.watch(dioProvider),
    ref.watch(tokenDatasourceProvider),
  );
});

final getProfileRepoProvider = Provider(
  (ref) => ProfileRepoIMPL(ref.watch(getProfileDatasourceProvider)),
);

final getProfileProvider = Provider(
  (ref) => GetProfile(ref.watch(getProfileRepoProvider)),
);

class GetProfileNotifier extends AsyncNotifier<Map<String, dynamic>> {
  @override
  Future<Map<String, dynamic>> build() async {
    final response = await ref.watch(getProfileProvider)();
    log("output $response");
    return response;
  }
}

final getProfileNotifierProvider =
    AsyncNotifierProvider.autoDispose<GetProfileNotifier, Map<String, dynamic>>(
      GetProfileNotifier.new,
    );
