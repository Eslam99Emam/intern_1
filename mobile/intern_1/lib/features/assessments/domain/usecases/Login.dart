import 'package:intern_1/features/auth/domain/repositories/login_Repository.dart';

class Login {
  LoginRepository repo;

  Login(this.repo);

  Future<bool> call({required String email, required String password}) async {
    return await repo.login(email: email, password: password);
  }
}
