import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorageDataSource {
  final _storage = const FlutterSecureStorage();

  Future<String?> readToken() => _storage.read(key: 'token');
}
