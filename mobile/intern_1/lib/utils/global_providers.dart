import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intern_1/features/core/data/datasource/token_storage_ds.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: "https://intern-1-25kn.onrender.com/api/v1",
      connectTimeout: const Duration(seconds: 10),
    ),
  );

  dio.interceptors.add(LogInterceptor());
  return dio;
});

final tokenDatasourceProvider = Provider<TokenStorageDataSource>(
  (ref) => TokenStorageDataSource(),
);
