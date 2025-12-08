import 'package:intern_1/features/auth/domain/entities/User_Entity.dart';
import 'package:intern_1/features/auth/domain/repositories/signup_Repository.dart';

class Signup {
  SignUpRepository repo;

  Signup(this.repo);

  Future<void> call({required UserEntity user}) async {
    await repo.signUp(user: user);
  }
}
