import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_1/features/core/data/datasource/token_storage_ds.dart';
import 'package:intern_1/utils/API_config.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(baseUrl: API_URL, connectTimeout: const Duration(seconds: 15)),
  );

  dio.interceptors.add(LogInterceptor());
  return dio;
});


final tokenDatasourceProvider = Provider<TokenStorageDataSource>(
  (ref) => TokenStorageDataSource(),
);
