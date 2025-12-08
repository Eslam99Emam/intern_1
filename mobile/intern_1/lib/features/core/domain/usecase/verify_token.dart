import 'package:intern_1/features/core/domain/repository/verify_token_repo.dart';

class VerifyToken {
  VerifyTokenRepo repo;

  VerifyToken(this.repo);

  Future<bool> call() {
    return repo.verifyToken();
  }
}
